#!/bin/bash

set -e

echo -e "-----------------------------------------------------\n|                   \e[1mtascscripts\e[0m                     |\n|        Copyright 2024 Tarikko-ScetayhChan         |\n|https://github.com/Tarikko-ScetayhChan/tascscripts/|\n-----------------------------------------------------\n-----------------------------------------------------\n|                gentoo-install-2.sh                |\n-----------------------------------------------------\nThis file is part of tascscripts.\ntascscripts is free software: you can redistribute it\nand/or modify it under the terms of the GNU General\nPublic License as published by the Free Software\nFoundation, either version 3 of the License, or (at\nyour option) any later version.\ntascscripts is distributed in the hope that it will\nbe useful, but WITHOUT ANY WARRANTY; without even the\nimplied warranty of MERCHANTABILITY or FITNESS FOR A\nPARTICULAR PURPOSE. See the GNU General Public\nLicense for more details.\nYou should have received a copy of the GNU General\nPublic License along with tascscripts. If not, see\n<https://www.gnu.org/licenses/>.\n"; sleep 5

echo -e "\e[33mWarning: \e[0mEdit '${PATH_SCRIPTS_ROOT}/env/gentoo-install-env.conf'\nbefore running this script.\n"; sleep 5

echo -e "\e[33mWarning: \e[0mEdit '${PATH_SCRIPTS_ROOT}/\${makedotconf}' before running this script.\n"; sleep 5

echo -e "\e[33mWarning: \e[0mYou will have 5 seconds to cancel this\nscript."; sleep 1; echo "5"; sleep 1; echo "4"; sleep 1; echo "3"; sleep 1; echo "2"; sleep 1; echo "1"; sleep 1

echo -e "\n\e[32m==> Step 1 of 29: \e[0mTo set the environment variables\n"; sleep 1
export PATH_SCRIPTS_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" &&
echo -e "PATH_SCRIPTS_ROOT=${PATH_SCRIPTS_ROOT}";
source ${PATH_SCRIPTS_ROOT}/env/gentoo-install-env.conf &&
echo -e "\e[32m\n${PATH_SCRIPTS_ROOT}/env/gentoo-install-env.conf\n-----------------------------------------------------\e[0m";
cat -n ${PATH_SCRIPTS_ROOT}/env/gentoo-install-env.conf;
echo -e "\n\e[32m-----------------------------------------------------\e[0m";

echo -e "\n\e[32m==> Step 2 of 29: \e[0mTo load settings\n"; sleep 1
source /etc/profile &&
export PS1="(chroot) ${PS1}" &&

echo -e "\n\e[32m==> Step 3 of 29: \e[0mTo install the latest snapshot\n"; sleep 1
rm -f -v /var/db/repos/gentoo/metadata/timestamp.x;
emerge-webrsync &&
emerge --sync;

echo -e "\n\e[32m==> Step 4 of 29: \e[0mTo copy 'make.conf'\n"; sleep 1
cat ${PATH_SCRIPTS_ROOT}/${makedotconf} > /etc/portage/make.conf;
echo -e "\e[32m\n/etc/portage/make.conf\n-----------------------------------------------------\e[0m";
cat -n /etc/portage/make.conf;
echo -e "\n\e[32m-----------------------------------------------------\e[0m";

echo -e "\n\e[32m==> Step 5 of 29: \e[0mTo install cpuid2cpuflags'\n"; sleep 1
emerge cpuid2cpuflags &&

echo -e "\n\e[32m==> Step 6 of 29: \e[0mTo run 'cpuid2cpuflags'\n"; sleep 1
cpuid2cpuflags &&
echo "*/* $(cpuid2cpuflags)" > /etc/portage/package.use/00cpu-flags;
echo -e "\e[32m\n/etc/portage/package.use/00cpu-flags\n-----------------------------------------------------\e[0m";
cat -n /etc/portage/package.use/00cpu-flags;
echo -e "\n\e[32m-----------------------------------------------------\e[0m";

echo -e "\n\e[32m==> Step 7 of 29: \e[0mTo install ccache, aria2 and sccache\n"; sleep 1
emerge ccache aria2 &&

echo -e "\n\e[32m==> Step 8 of 29: \e[0mTo configure ccache and aria2\n"; sleep 1
sed -i --debug "s/#FETCHCOMMAND/FETCHCOMMAND/g" /etc/portage/make.conf &&
sed -i --debug "s/#RESUMECOMMAND/RESUMECOMMAND/g" /etc/portage/make.conf &&
sed -i --debug "s/#FEATURES/FEATURES/g" /etc/portage/make.conf &&
sed -i --debug "s/#CCACHE_DIR/CCACHE_DIR/g" /etc/portage/make.conf &&
sed -i --debug "s/#RUSTC_WRAPPER/RUSTC_WRAPPER/g" /etc/portage/make.conf &&

echo -e "\e[32m\n/etc/portage/make.conf\n-----------------------------------------------------\e[0m";
cat -n /etc/portage/make.conf;
echo -e "\n\e[32m-----------------------------------------------------\e[0m";

echo -e "\n\e[32m==> Step 9 of 29: \e[0mTo update the @world set\n"; sleep 1
emerge --verbose --update --deep --newuse @world;
etc-update --automode -3;
emerge --verbose --update --deep --newuse @world &&
etc-update --automode -3;
env-update;
source /etc/profile;
export PS1="(chroot) ${PS1}";

echo -e "\n\e[32m==> Step 10 of 29: \e[0mTo To set the timezone and configure locates\n"; sleep 1
echo "Asia/Shanghai" > /etc/timezone &&
emerge --config sys-libs/timezone-data &&
nano /etc/locale.gen &&
locale-gen &&
eselect locale set C &&
env-update;
etc-update;
source /etc/profile;
export PS1="(chroot) ${PS1}";

echo -e "\n\e[32m==> Step 11 of 29: \e[0mTo install firmware\n"; sleep 1
emerge sys-kernel/linux-firmware;

echo -e "\n\e[32m==> Step 12 of 29: \e[0mTo install Distribution kernel\n"; sleep 1
echo "sys-kernel/installkernel dracut" >> /etc/portage/package.use/installkernel &&
emerge sys-kernel/gentoo-kernel-bin &&

echo -e "\n\e[32m==> Step 13 of 29: \e[0mTo run 'ls /lib/modules'\n"; sleep 1
ls -alhF --color /lib/modules

echo -e "\n\e[32m==> Step 14 of 29: \e[0mTo create the fstab file\n"; sleep 1
emerge genfstab &&
cp -v /etc/fstab{,.bak};
genfstab -U / >> /etc/fstab &&
echo -e "\e[32m\n/etc/fstab\n-----------------------------------------------------\e[0m";
cat -n /etc/fstab;
echo -e "\n\e[32m-----------------------------------------------------\e[0m";

echo -e "\n\e[32m==> Step 15 of 29: \e[0mTo set the hostname\n"; sleep 1
echo "${hostname}" > /etc/hostname &&
echo -e "\e[32m\n/etc/hostname\n-----------------------------------------------------\e[0m";
cat -n /etc/hostname;
echo -e "\n\e[32m-----------------------------------------------------\e[0m";

echo -e "\n\e[32m==> Step 16 of 29: \e[0mTo set hosts\n"; sleep 1
mv -v /etc/hosts{,.bak};
echo "127.0.0.1	localhost" >> /etc/hosts &&
echo "::1	localhost" >> /etc/hosts &&
echo "127.0.1.1	${hostname}.localdomain	${hostname}" >> /etc/hosts &&
echo -e "\e[32m\n/etc/hosts\n-----------------------------------------------------\e[0m";
cat -n /etc/hosts;
echo -e "\n\e[32m-----------------------------------------------------\e[0m";

echo -e "\n\e[32m==> Step 17 of 29: \e[0mTo install dhcpcd\n"; sleep 1
emerge net-misc/dhcpcd &&

echo -e "\n\e[32m==> Step 18 of 29: \e[0mTo enable dhcpcd service\n"; sleep 1
rc-update add dhcpcd default &&

echo -e "\n\e[32m==> Step 19 of 29: \e[0mTo set the root password\n"; sleep 1
passwd &&

echo -e "\n\e[32m==> Step 20 of 29: \e[0mTo install sudo\n"; sleep 1
emerge app-admin/sudo &&

echo -e "\n\e[32m==> Step 21 of 29: \e[0mTo configure sudo\n"; sleep 1
sed -i --debug "s/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/g" /etc/sudoers &&
echo -e "\e[32m\n/etc/sudoers\n-----------------------------------------------------\e[0m";
cat -n /etc/sudoers;
echo -e "\n\e[32m-----------------------------------------------------\e[0m";

echo -e "\n\e[32m==> Step 22 of 29: \e[0mTo install system tools\n"; sleep 1
emerge app-admin/sysklogd sys-process/cronie sys-apps/mlocate app-shells/bash-completion net-misc/chrony sys-fs/xfsprogs sys-fs/e2fsprogs sys-fs/dosfstools sys-fs/btrfs-progs sys-fs/zfs sys-fs/jfsutils sys-fs/dosfstools net-dialup/ppp net-wireless/iw net-wireless/wpa_supplicant ${extra_packages} &&

echo -e "\n\e[32m==> Step 23 of 29: \e[0mTo enable system tool services\n"; sleep 1
rc-update add sysklogd default &&
rc-update add cronie default &&
rc-update add sshd default &&
rc-update add chronyd default &&

echo -e "\n\e[32m==> Step 24 of 29: \e[0mTo add a user for daily use\n"; sleep 1
useradd -m -G audio,cdrom,floppy,portage,usb,video,wheel -s ${new_user_login_shell} ${new_user_username} &&

echo -e "\n\e[32m==> Step 25 of 29: \e[0mTo set the new user password\n"; sleep 1
passwd ${new_user_username} &&

echo -e "\n\e[32m==> Step 26 of 29: \e[0mTo install grub\n"; sleep 1
emerge sys-boot/grub &&

echo -e "\n\e[32m==> Step 27 of 29: \e[0mTo install grub files\n"; sleep 1
grub-install --target=${grub_install_target} --efi-directory=/boot/efi --bootloader-id=${grub_install_bootloader_id} &&

echo -e "\n\e[32m==> Step 28 of 29: \e[0mTo generate grub configuration\n"; sleep 1
grub-mkconfig -o /boot/grub/grub.cfg &&
echo -e "\e[32m\n/boot/grub/grub.cfg\n-----------------------------------------------------\e[0m";
cat -n /boot/grub/grub.cfg;
echo -e "\n\e[32m-----------------------------------------------------\e[0m";

echo -e "\n\e[32m==> Step 29 of 29: \e[0mTo exit the chrooting\n"; sleep 1
exit