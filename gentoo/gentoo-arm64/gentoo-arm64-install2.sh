#!/bin/sh

	####### gentoo-arm64-install2.sh
	####### https://github.com/Tarikko-ScetayhChan/tascscripts/

	##### Read and edit this script before chmod +x and run it.

	##### Run this script after chrooting.

	### load settings
source /etc/profile &&
source ~/.bashrc ;

	### install the latest snapshot
rm -f /var/db/repos/gentoo/metadata/timestamp.x ;
emerge-webrsync &&
	# Uncomment the command below if you want to install the latest cache in 1 hour.
#emerge --sync ;

	### install ccache and aria2
emerge ccache aria2 ;
	# Uncommment the contents about ccache and aria2 in /etc/portage/make.conf.
em ;

	### updating the @world set
emerge --ask --verbose --update --deep --newuse @world ;
etc-update
emerge --ask --verbose --update --deep --newuse @world &&

	### set the timezone and configure locales
echo "Asia/Shanghai" > /etc/timezone &&
emerge --config sys-libs/timezone-data &&
nano /etc/locale.gen &&
locale-gen &&
eselect locale set C &&
env-update &&
source /etc/profile &&
source ~/.bashrc ;

	### install firmware
emerge sys-kernel/linux-firmware &&

	### genkernel
mkdir /etc/portage/package.license &&
echo "sys-kernel/linux-firmware @BINARY-REDISTRIBUTABLE" >> /etc/portage/package.license/linux-firmware &&
emerge sys-kernel/genkernel &&
genkernel --mountboot --install all &&

	### installkernel
echo "sys-kernel/installkernel grub" >> /etc/portage/package.use/installkernel &&
emerge sys-kernel/installkernel &&
echo "layout=grub" >> /etc/kernel/install.conf &&

	### building an initramfs
	# Edit the kernel version below to yours.
dracut --kver=6.6.13-gentoo-arm64 --force &&

	### create the fstab file
emerge genfstab &&
cp /etc/fstab{,.bak} ;
genfstab -U / >> /etc/fstab &&

	### configure the networking information
	# Edit the hostname below into yours. 
echo "YupyeRGentoo" > /etc/hostname &&
mv /etc/hosts{,.bak} ;
echo "127.0.0.1	localhost" >> /etc/hosts &&
echo "::1	localhost" >> /etc/hosts &&
echo "127.0.1.1	YupyeRGentoo.localdomain	YupyeRGentoo" >> /etc/hosts &&
emerge net-misc/dhcpcd &&
rc-update add dhcpcd default &&
rc-service dhcpcd start ;

	### set the root password
passwd &&

	### install system tools
emerge app-admin/sysklogd sys-process/cronie sys-apps/mlocate app-shells/bash-completion net-misc/chrony sys-fs/dosfstools net-dialup/ppp net-wireless/iw net-wireless/wpa_supplicant virtual/man neofetch dev-vcs/git links&&
rc-update add sysklogd default &&
rc-update add cronie default &&
rc-update add sshd default &&
rc-update add chronyd default &&

	### install the boot loader
emerge sys-boot/grub &&
	# Edit the --bootloader-id option to yours.
grub-install --target=arm64-efi --efi-directory=/boot/efi --bootloader-id=YupyeRGrub &&
grub-mkconfig -o /boot/grub/grub.cfg &&

	### exit the chrooting
exit