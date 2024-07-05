#!/bin/bash

set -e

source functions
source install.conf

PrintBrand $0
RemindConfiguration
WaitForRegret

PrintStep 1 26 "To load settings"
source /etc/profile
export PS1="(chroot) ${PS1}"
PrintStep 1 26 "To load settings"

PrintStep 2 26 "To install the latest snapshot"
rm -rf -v /var/db/repos/gentoo/metadata/timestamp.x
emerge-webrsync
if [ ${gis_install_whetherToRunEmergeSync} != no ]; then
    emerge --sync
fi
PrintStep 2 26 "To install the latest snapshot"

PrintStep 3 26 "To deploy 'make.conf'"
mv /etc/portage/make.conf{,.bak}
cp make.conf /etc/portage/
PrintStep 3 26 "To deploy 'make.conf'"

PrintStep 4 26 "To install cpuid2cpuflags'"
emerge cpuid2cpuflags
PrintStep 4 26 "To install cpuid2cpuflags'"

PrintStep 5 26 "To run 'cpuid2cpuflags'"
cpuid2cpuflags &&
echo "*/* $(cpuid2cpuflags)" > /etc/portage/package.use/00cpu-flags
PrintStep 5 26 "To run 'cpuid2cpuflags'"

PrintStep 6 26 "To install ccache and aria2"
emerge ccache aria2
PrintStep 6 26 "To install ccache and aria2"

PrintStep 7 26 "To configure ccache and aria2"
sed -i "s/#FETCHCOMMAND/FETCHCOMMAND/g" /etc/portage/make.conf
sed -i "s/#RESUMECOMMAND/RESUMECOMMAND/g" /etc/portage/make.conf
sed -i "s/#FEATURES/FEATURES/g" /etc/portage/make.conf
sed -i "s/#CCACHE_DIR/CCACHE_DIR/g" /etc/portage/make.conf
PrintStep 7 26 "To configure ccache and aria2"

PrintStep 8 26 "To update the @world set"
emerge --verbose --update --deep --newuse @world
etc-update --automode -3
emerge --verbose --update --deep --newuse @world
etc-update --automode -3
env-update
source /etc/profile
export PS1="(chroot) ${PS1}"
PrintStep 8 26 "To update the @world set"

PrintStep 9 26 "To set the timezone and configure locates"
echo "Asia/Shanghai" > /etc/timezone
emerge --config sys-libs/timezone-data
sed -i "s/#en_US/en_US/g" /etc/locale.gen
locale-gen
eselect locale set C
env-update;
etc-update;
source /etc/profile;
export PS1="(chroot) ${PS1}";
PrintStep 9 26 "To set the timezone and configure locates"

PrintStep 10 26 "To install firmware"
emerge sys-kernel/linux-firmware;
PrintStep 10 26 "To install firmware"

PrintStep 11 26 "To install distribution kernel"
echo "sys-kernel/installkernel dracut" >> /etc/portage/package.use/installkernel
emerge sys-kernel/gentoo-kernel-bin
PrintStep 11 26 "To install distribution kernel"

PrintStep 12 26 "To create the fstab file"
emerge genfstab &&
genfstab -U / >> /etc/fstab
PrintStep 12 26 "To create the fstab file"

PrintStep 13 26 "To set the hostname"
echo "${gis_install_hostname}" > /etc/hostname
PrintStep 13 26 "To set the hostname"

PrintStep 14 26 "To set hosts"
echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1	localhost" >> /etc/hosts
echo "127.0.1.1	${gis_install_hostname}.localdomain	${gis_install_hostname}" >> /etc/hosts
PrintStep 14 26 "To set hosts"

PrintStep 15 26 "To install dhcpcd"
emerge net-misc/dhcpcd
PrintStep 15 26 "To install dhcpcd"

PrintStep 16 26 "To enable dhcpcd service"
rc-update add dhcpcd default
PrintStep 16 26 "To enable dhcpcd service"

PrintStep 17 26 "To install sudo"
emerge app-admin/sudo
PrintStep 17 26 "To install sudo"

PrintStep 18 26 "To configure sudo"
sed -i "s/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/g" /etc/sudoers
PrintStep 18 26 "To configure sudo"

PrintStep 19 26 "To install system tools and extra packages"
emerge app-admin/sysklogd sys-process/cronie sys-apps/mlocate app-shells/bash-completion net-misc/chrony sys-fs/xfsprogs sys-fs/e2fsprogs sys-fs/dosfstools sys-fs/btrfs-progs sys-fs/zfs sys-fs/jfsutils sys-fs/dosfstools net-dialup/ppp net-wireless/iw net-wireless/wpa_supplicant ${gis_install_extraPackages}
PrintStep 19 26 "To install system tools and extra packages"

PrintStep 20 26 "To enable system tool services"
rc-update add sysklogd default 
rc-update add cronie default
rc-update add sshd default
rc-update add chronyd default
PrintStep 20 26 "To enable system tool services"

PrintStep 21 26 "To add a user for daily use"
useradd -m -G audio,cdrom,floppy,portage,usb,video,wheel ${gis_install_newUserUsername}
PrintStep 21 26 "To add a user for daily use"

PrintStep 22 26 "To install grub"
emerge sys-boot/grub
PrintStep 22 26 "To install grub"

PrintStep 23 26 "To install bootloader"
grub-install --target=${gis_install_grubInstallTarget} --efi-directory=/boot/efi --bootloader-id=${YupyeGRUB}
PrintStep 23 26 "To install bootloader"

PrintStep 24 26 "To generate grub configuration"
grub-mkconfig -o /boot/grub/grub.cfg
PrintStep 24 26 "To generate grub configuration"

PrintStep 25 26 "To set the root password"
passwd
PrintStep 25 26 "To set the root password"

PrintStep 26 26 "To set the new user password"
passwd ${gis_install_newUserUsername}
PrintStep 26 26 "To set the new user password"