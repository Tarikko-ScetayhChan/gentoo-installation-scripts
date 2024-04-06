#!/bin/bash

set -e

echo -e "-----------------------------------------------------\n|                   \e[1mtascscripts\e[0m                     |\n|        Copyright 2024 Tarikko-ScetayhChan         |\n|https://github.com/Tarikko-ScetayhChan/tascscripts/|\n-----------------------------------------------------\n-----------------------------------------------------\n|                gentoo-install-3.sh                |\n-----------------------------------------------------\nThis file is part of tascscripts.\ntascscripts is free software: you can redistribute it\nand/or modify it under the terms of the GNU General\nPublic License as published by the Free Software\nFoundation, either version 3 of the License, or (at\nyour option) any later version.\ntascscripts is distributed in the hope that it will\nbe useful, but WITHOUT ANY WARRANTY; without even the\nimplied warranty of MERCHANTABILITY or FITNESS FOR A\nPARTICULAR PURPOSE. See the GNU General Public\nLicense for more details.\nYou should have received a copy of the GNU General\nPublic License along with tascscripts. If not, see\n<https://www.gnu.org/licenses/>.\n"; sleep 5

echo -e "\e[33mWarning: \e[0mEdit '${PATH_SCRIPTS_ROOT}/env/gentoo-install-env-3.conf'\nbefore running this script.\n"; sleep 5

echo -e "\e[33mWarning: \e[0mYou will have 5 seconds to cancel this\nscript."; sleep 1; echo "5"; sleep 1; echo "4"; sleep 1; echo "3"; sleep 1; echo "2"; sleep 1; echo "1"; sleep 1

echo -e "\n\e[32m==> Step 1 of 18: \e[0mTo set the environment variables\n"; sleep 1
export PATH_SCRIPTS_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" &&
echo -e "PATH_SCRIPTS_ROOT=${PATH_SCRIPTS_ROOT}";
source ${PATH_SCRIPTS_ROOT}/env/gentoo-install-env-3.conf &&
echo -e "\e[32m\n${PATH_SCRIPTS_ROOT}/env/gentoo-install-env-3.conf\n-----------------------------------------------------\e[0m";
cat ${PATH_SCRIPTS_ROOT}/env/gentoo-install-env-3.conf;
echo -e "\n\e[32m-----------------------------------------------------\e[0m";

echo -e "\n\e[32m==> Step 2 of 18: \e[0mTo build an initramfs\n"; sleep 1
dracut --kver=${dracut_kver} --force &&

echo -e "\n\e[32m==> Step 3 of 18: \e[0mTo create the fstab file\n"; sleep 1
emerge genfstab &&
cp -v /etc/fstab{,.bak};
genfstab -U / >> /etc/fstab &&
echo -e "\e[32m\n/etc/fstab\n-----------------------------------------------------\e[0m";
cat /etc/fstab;
echo -e "\n\e[32m-----------------------------------------------------\e[0m";

echo -e "\n\e[32m==> Step 4 of 18: \e[0mTo set the hostname\n"; sleep 1
echo "${hostname}" > /etc/hostname &&
echo -e "\e[32m\n/etc/hostname\n-----------------------------------------------------\e[0m";
cat /etc/hostname;
echo -e "\n\e[32m-----------------------------------------------------\e[0m";

echo -e "\n\e[32m==> Step 5 of 18: \e[0mTo set hosts\n"; sleep 1
mv -v /etc/hosts{,.bak};
echo "127.0.0.1	localhost" >> /etc/hosts &&
echo "::1	localhost" >> /etc/hosts &&
echo "127.0.1.1	${hostname}.localdomain	${hostname}" >> /etc/hosts &&
echo -e "\e[32m\n/etc/hosts\n-----------------------------------------------------\e[0m";
cat /etc/hosts;
echo -e "\n\e[32m-----------------------------------------------------\e[0m";

echo -e "\n\e[32m==> Step 6 of 18: \e[0mTo install dhcpcd\n"; sleep 1
emerge net-misc/dhcpcd &&

echo -e "\n\e[32m==> Step 7 of 18: \e[0mTo enable dhcpcd service\n"; sleep 1
rc-update add dhcpcd default &&
rc-service dhcpcd start;

echo -e "\n\e[32m==> Step 8 of 18: \e[0mTo set the root password\n"; sleep 1
passwd &&

echo -e "\n\e[32m==> Step 9 of 18: \e[0mTo install sudo\n"; sleep 1
emerge app-admin/sudo &&

echo -e "\n\e[32m==> Step 10 of 18: \e[0mTo configure sudo\n"; sleep 1
SED

echo -e "\n\e[32m==> Step 11 of 18: \e[0mTo install system tools\n"; sleep 1
emerge app-admin/sysklogd sys-process/cronie sys-apps/mlocate app-shells/bash-completion net-misc/chrony sys-fs/xfsprogs sys-fs/e2fsprogs sys-fs/dosfstools sys-fs/btrfs-progs sys-fs/zfs sys-fs/jfsutils sys-fs/dosfstools net-dialup/ppp net-wireless/iw net-wireless/wpa_supplicant ${extra_packages} &&

echo -e "\n\e[32m==> Step 12 of 18: \e[0mTo enable system tool services\n"; sleep 1
rc-update add sysklogd default &&
rc-update add cronie default &&
rc-update add sshd default &&
rc-update add chronyd default &&

echo -e "\n\e[32m==> Step 13 of 18: \e[0mTo add a user for daily use\n"; sleep 1
useradd -m -G audio,cdrom,floppy,portage,usb,video,wheel -s ${new_user_login_shell} ${new_user_username} &&

echo -e "\n\e[32m==> Step 14 of 18: \e[0mTo set the new user password\n"; sleep 1
passwd ${new_user_username} &&

echo -e "\n\e[32m==> Step 15 of 18: \e[0mTo install grub\n"; sleep 1
emerge sys-boot/grub &&

echo -e "\n\e[32m==> Step 16 of 18: \e[0mTo install grub files\n"; sleep 1
grub-install --target=${grub_install_target} --efi-directory=/boot/efi --bootloader-id=${grub_install_bootloader_id} &&

echo -e "\n\e[32m==> Step 17 of 18: \e[0mTo generate grub configuration\n"; sleep 1
grub-mkconfig -o /boot/grub/grub.cfg &&
echo -e "\e[32m\n/boot/grub/grub.cfg\n-----------------------------------------------------\e[0m";
cat /boot/grub/grub.cfg;
echo -e "\n\e[32m-----------------------------------------------------\e[0m";

echo -e "\n\e[32m==> Step 18 of 18: \e[0mTo exit the chrooting\n"; sleep 1
exit