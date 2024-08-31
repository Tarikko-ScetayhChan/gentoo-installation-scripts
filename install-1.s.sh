#!/bin/bash

set -e

##include {
source functions
source install.conf
##}

PrintBrand $0
RemindConfiguration
WaitForRegret

PrintStepOn 1 18 "net-setup"
if [ ${gis_install_whetherToRunNetsetup} != no ]; then
    net-setup
fi
PrintStepOff 1 18 "net-setup"

PrintStepOn 2 18 "To replace nameserver in '/etc/resolv.conf'"
sed -i "s|nameserver.*|nameserver ${gis_install_nameserver}|g" /etc/resolv.conf
PrintStepOff 2 18 "To replace nameserver in '/etc/resolv.conf'"

PrintStepOn 3 18 "To generate the fdisk script"
mkdir -v tmp
echo -e "g\nn\n1\n\n+${gis_install_efiPartitionSize}\nt\n1\nn\n2\n\n+${gis_install_bootPartitionSize}\nn\n3\n\n+${gis_install_swapPartitionSize}\nn\n4\n\n\nw" > tmp/gentoo-install-fdisk.txt
PrintStepOff 3 18 "To generate the fdisk script"

PrintStepOn 4 18 "To partition the disk"
cat tmp/gentoo-install-fdisk.txt | fdisk ${gis_install_disk}
PrintStepOff 4 18 "To partition the disk"

PrintStepOn 5 18 "To create file systems"
mkfs.fat -F 32 ${gis_install_efiPartition}
mkfs.${gis_install_bootPartitionFs} ${gis_install_bootPartition}
mkswap ${gis_install_swapPartition}
mkfs.${gis_install_rootPartitionFs} ${gis_install_rootPartition}
PrintStepOff 5 18 "To create file systems"

PrintStepOn 6 18 "To mount file systems"
mount -v ${gis_install_rootPartition} --mkdir /mnt/gentoo
mount -v ${gis_install_bootPartition} --mkdir /mnt/gentoo/boot
mount -v ${gis_install_efiPartition} --mkdir /mnt/gentoo/boot/efi
swapon -v ${gis_install_swapPartition}
PrintStepOff 6 18 "To mount file systems"

PrintStepOn 7 18 "To create swapfile"
fallocate -l ${gis_install_swapfileSize} -v /mnt/gentoo/swapfile
chmod 600 /mnt/gentoo/swapfile
mkswap /mnt/gentoo/swapfile
PrintStepOff 7 18 "To create swapfile"

PrintStepOn 8 18 "To mount swapfile"
swapon /mnt/gentoo/swapfile
PrintStepOff 8 18 "To mount swapfile"

PrintStepOn 9 18 "To set the date and the time"
hwclock -v --systohc
date
PrintStepOff 9 18 "To set the date and the time"

PrintStepOn 10 18 "To enter '/mnt/gentoo'"
export gis_install_originalDirectory=$(pwd)
cd /mnt/gentoo
pwd
PrintStepOff 10 18 "To enter '/mnt/gentoo'"

PrintStepOn 11 18 "To download the stage file"
${gis_install_stage3DownloadTool} ${gis_install_stage3DownloadAddress}
PrintStepOff 11 18 "To download the stage file"

PrintStepOn 12 18 "To extract the stage file"
tar xpvf *.tar.xz --xattrs-include='*.*' --numeric-owner
PrintStepOff 12 18 "To extract the stage file"

PrintStepOn 13 18 "To copy the Gentoo repository configuration file"
mkdir -pv /mnt/gentoo/etc/portage/repos.conf
cp -v /mnt/gentoo/usr/share/portage/config/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf
PrintStepOff 13 18 "To copy the Gentoo repository configuration file"

PrintStepOn 14 18 "To replace the sync-uri variable"
sed -i "s|rsync:\/\/rsync.gentoo.org\/gentoo-portage|${gis_install_rsyncAddress}|g" /mnt/gentoo/etc/portage/repos.conf/gentoo.conf
PrintStepOff 14 18 "To replace the sync-uri variable"

PrintStepOn 15 18 "To copy DNS info"
cp -v --dereference /etc/resolv.conf /mnt/gentoo/etc/
PrintStepOff 15 18 "To copy DNS info"

PrintStepOn 16 18 "To mount the necessary filesystems"
mount -v --types proc /proc /mnt/gentoo/proc
mount -v --rbind /sys /mnt/gentoo/sys
mount -v --make-rslave /mnt/gentoo/sys
mount -v --rbind /dev /mnt/gentoo/dev
mount -v --make-rslave /mnt/gentoo/dev
mount -v --bind /run /mnt/gentoo/run
mount -v --make-slave /mnt/gentoo/run
PrintStepOff 16 18 "To mount the necessary filesystems"

PrintStepOn 17 18 "To copy scripts into the new root"
cd ${gis_install_originalDirectory}
mkdir -pv /mnt/gentoo/gentoo-installation-scripts
cp -rv ./* /mnt/gentoo/gentoo-installation-scripts/
PrintStepOff 17 18 "To copy scripts into the new root"

PrintStepOn 18 18 "To enter the new environment"
chroot /mnt/gentoo /bin/bash
PrintStepOff 18 18 "To enter the new environment"