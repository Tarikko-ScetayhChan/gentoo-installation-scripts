#!/bin/bash

echo -e "-----------------------------------------------------"
echo -e "|                   \e[1mtascscripts\e[0m                     |"
echo -e "|        Copyright 2024 Tarikko-ScetayhChan         |"
echo -e "|https://github.com/Tarikko-ScetayhChan/tascscripts/|"
echo -e "-----------------------------------------------------"
echo -e "-----------------------------------------------------"
echo -e "|             gentoo-arm64-install2.sh              |"
echo -e "-----------------------------------------------------"
echo -e "This file is part of tascscripts."
echo -e "tascscripts is free software: you can redistribute it"
echo -e "and/or modify it under the terms of the GNU General"
echo -e "Public License as published by the Free Software"
echo -e "Foundation, either version 3 of the License, or (at"
echo -e "your option) any later version."
echo -e "tascscripts is distributed in the hope that it will"
echo -e "be useful, but WITHOUT ANY WARRANTY; without even the"
echo -e "implied warranty of MERCHANTABILITY or FITNESS FOR A"
echo -e "PARTICULAR PURPOSE. See the GNU General Public"
echo -e "License for more details."
echo -e "You should have received a copy of the GNU General"
echo -e "Public License along with tascscripts. If not, see"
echo -e "<https://www.gnu.org/licenses/>."
echo
sleep 5

echo -e "\e[32mInfo: \e[0mThe set environment variables are:"
export dracut_kver=6.6.13-gentoo-arm64
export hostname=YupyeSGentoo
export grub_hyphen_install_target=arm64-efi
export grub_hyphen_install_bootloader_hyphen_id=YupyeSGrub
echo -e "    dracut_kver=${dracut_kver}"
echo -e "    hostname=${hostname}"
echo -e "    grub_hyphen_install_target=${grub_hyphen_install_target}"
echo -e "    grub_hyphen_install_bootloader_hyphen_id=${grub_hyphen_install_bootloader_hyphen_id}"

echo -e "\e[33mWarning: \e[0mRead and edit this script before you chmod"
echo -e "+x and run it."
echo
sleep 5

echo -e "\e[33mWarning: \e[0mYou will have 10 seconds to cancel this"
echo -e "script."
sleep 1
echo "10"
sleep 1
echo "9"
sleep 1
echo "8"
sleep 1
echo "7"
sleep 1
echo "6"
sleep 1
echo "5"
sleep 1
echo "4"
sleep 1
echo "3"
sleep 1
echo "2"
sleep 1
echo "1"
sleep 1

echo
echo -e "    \e[32m==> Step 1: \e[0mTo load settings"
echo
source /etc/profile &&
source ~/.bashrc;

echo
echo -e "    \e[32m==> Step 2: \e[0mTo install the latest snapshot"
echo
rm -f /var/db/repos/gentoo/metadata/timestamp.x;
emerge-webrsync &&
#emerge --sync;

echo
echo -e "    \e[32m==> Step 3: \e[0mTo install ccache and aria2"
echo
emerge ccache aria2;
emmc;

echo
echo -e "    \e[32m==> Step 4: \e[0mTo update the @world set"
echo
emerge --ask --verbose --update --deep --newuse @world;
etc-update &&
emerge --ask --verbose --update --deep --newuse @world &&

echo
echo -e "    \e[32m==> Step 5: \e[0mTo set the timezone and configure"
echo -e "        locales"
echo
echo "Asia/Shanghai" > /etc/timezone &&
emerge --config sys-libs/timezone-data &&
nano /etc/locale.gen &&
locale-gen &&
eselect locale set C &&
env-update &&
source /etc/profile &&
source ~/.bashrc;

echo
echo -e "    \e[32m==> Step 6: \e[0mTo install firmware"
echo
emerge sys-kernel/linux-firmware &&

echo
echo -e "    \e[32m==> Step 7: \e[0mgenkernel"
echo
mkdir /etc/portage/package.license &&
echo "sys-kernel/linux-firmware @BINARY-REDISTRIBUTABLE" >> /etc/portage/package.license/linux-firmware &&
emerge sys-kernel/genkernel &&
genkernel --mountboot --install all &&

echo
echo -e "    \e[32m==> Step 8: \e[0installkernel"
echo
echo "sys-kernel/installkernel grub" >> /etc/portage/package.use/installkernel &&
emerge sys-kernel/installkernel &&
echo "layout=grub" >> /etc/kernel/install.conf &&

echo
echo -e "    \e[32m==> Step 9: \e[0To build an initramfs"
echo
dracut --kver=${dracut_kver} --force &&

echo
echo -e "    \e[32m==> Step 10: \e[0To create the fstab file"
echo
emerge genfstab &&
cp /etc/fstab{,.bak};
genfstab -U / >> /etc/fstab &&

echo
echo -e "    \e[32m==> Step 11: \e[0To configure the networking information"
echo
echo "${hostname}" > /etc/hostname &&
mv /etc/hosts{,.bak};
echo "127.0.0.1	localhost" >> /etc/hosts &&
echo "::1	localhost" >> /etc/hosts &&
echo "127.0.1.1	${hostname}.localdomain	${hostname}" >> /etc/hosts &&
emerge net-misc/dhcpcd &&
rc-update add dhcpcd default &&
rc-service dhcpcd start;

echo
echo -e "    \e[32m==> Step 12: \e[0To set the root password"
echo
passwd &&

echo
echo -e "    \e[32m==> Step 13: \e[0To install system tools"
echo
emerge app-admin/sysklogd sys-process/cronie sys-apps/mlocate app-shells/bash-completion net-misc/chrony sys-fs/dosfstools net-dialup/ppp net-wireless/iw net-wireless/wpa_supplicant virtual/man neofetch dev-vcs/git links&&
rc-update add sysklogd default &&
rc-update add cronie default &&
rc-update add sshd default &&
rc-update add chronyd default &&

echo
echo -e "    \e[32m==> Step 13: \e[0To configure the bootloader"
echo
emerge sys-boot/grub &&
grub-install --target=${grub_hyphen_install_target} --efi-directory=/boot/efi --bootloader-id=${grub_hyphen_install_bootloader_hyphen_id} &&
grub-mkconfig -o /boot/grub/grub.cfg &&

echo
echo -e "    \e[32m==> Step 14: \e[0To exit the chrooting"
echo
exit