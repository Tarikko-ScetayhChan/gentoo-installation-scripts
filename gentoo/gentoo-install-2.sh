#!/bin/bash

set -e

echo -e "-----------------------------------------------------\n|                   \e[1mtascscripts\e[0m                     |\n|        Copyright 2024 Tarikko-ScetayhChan         |\n|https://github.com/Tarikko-ScetayhChan/tascscripts/|\n-----------------------------------------------------\n-----------------------------------------------------\n|                gentoo-install-2.sh                |\n-----------------------------------------------------\nThis file is part of tascscripts.\ntascscripts is free software: you can redistribute it\nand/or modify it under the terms of the GNU General\nPublic License as published by the Free Software\nFoundation, either version 3 of the License, or (at\nyour option) any later version.\ntascscripts is distributed in the hope that it will\nbe useful, but WITHOUT ANY WARRANTY; without even the\nimplied warranty of MERCHANTABILITY or FITNESS FOR A\nPARTICULAR PURPOSE. See the GNU General Public\nLicense for more details.\nYou should have received a copy of the GNU General\nPublic License along with tascscripts. If not, see\n<https://www.gnu.org/licenses/>.\n"; sleep 5

echo -e "\e[33mWarning: \e[0mEdit '${PATH_SCRIPTS_ROOT}/env/gentoo-install-env-2.conf'\nbefore running this script.\n"; sleep 5

echo -e "\e[33mWarning: \e[0mEdit '${PATH_SCRIPTS_ROOT}/${makedotconf}' before running this script.\n"
sleep 5

echo -e "\e[33mWarning: \e[0mYou will have 5 seconds to cancel this\nscript."; sleep 1; echo "5"; sleep 1; echo "4"; sleep 1; echo "3"; sleep 1; echo "2"; sleep 1; echo "1"; sleep 1

echo -e "\n\e[32m==> Step 1 of 13: \e[0mTo set the environment variables\n"; sleep 1
export PATH_SCRIPTS_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" &&
echo -e "PATH_SCRIPTS_ROOT=${PATH_SCRIPTS_ROOT}";
source ${PATH_SCRIPTS_ROOT}/env/gentoo-install-env-2.conf &&
echo -e "\e[32m\n${PATH_SCRIPTS_ROOT}/env/gentoo-install-env-2.conf\n-----------------------------------------------------\e[0m";
cat ${PATH_SCRIPTS_ROOT}/env/gentoo-install-env-2.conf;
echo -e "\n\e[32m-----------------------------------------------------\e[0m";

echo -e "\n\e[32m==> Step 2 of 13: \e[0mTo load settings\n"; sleep 1
source /etc/profile &&
export PS1="(chroot) ${PS1}" &&

echo -e "\n\e[32m==> Step 3 of 13: \e[0mTo install the latest snapshot\n"; sleep 1
rm -f -v /var/db/repos/gentoo/metadata/timestamp.x;
emerge-webrsync &&
emerge --sync;

echo -e "\n\e[32m==> Step 4 of 13: \e[0mTo copy 'make.conf'\n"; sleep 1
mv -v /etc/portage/make.conf{,.bak}
cp -v ${PATH_SCRIPTS_ROOT}/${makedotconf} /mnt/gentoo/etc/portage/make.conf;

echo -e "\n\e[32m==> Step 5 of 13: \e[0mTo install cpuid2cpuflags'\n"; sleep 1
emerge cpuid2cpuflags &&

echo -e "\n\e[32m==> Step 6 of 13: \e[0mTo run 'cpuid2cpuflags'\n"; sleep 1
cpuid2cpuflags &&
echo "*/* $(cpuid2cpuflags)" > /etc/portage/package.use/00cpu-flags;
echo -e "\e[32m\n/etc/portage/package.use/00cpu-flags\n-----------------------------------------------------\e[0m";
cat /etc/portage/package.use/00cpu-flags;
echo -e "\e[32m-----------------------------------------------------\e[0m";

echo -e "\n\e[32m==> Step 7 of 13: \e[0mTo install ccache, aria2 and sccache\n"; sleep 1
emerge ccache aria2 sccache --autounmask-write --autounmask &&
etc-update --automode -3 &&
emerge ccache aria2 sccache --autounmask-write --autounmask &&

echo -e "\n\e[32m==> Step 8 of 13: \e[0mTo configure ccache and aria2\n"; sleep 1
sed -i --debug "s/#FETCHCOMMAND/FETCHCOMMAND/g" /etc/portage/make.conf &&
sed -i --debug "s/#RESUMECOMMAND/RESUMECOMMAND/g" /etc/portage/make.conf &&
sed -i --debug "s/#FEATURES/FFEATURES/g" /etc/portage/make.conf &&
sed -i --debug "s/#CCACHE_DIR/CCACHE_DIR/g" /etc/portage/make.conf &&
sed -i --debug "s/#RUSTC_WRAPPER/RUSTC_WRAPPER/g" /etc/portage/make.conf &&
sed -i --debug "s/#SCCACHE_DIR/SCCACHE_DIR/g" /etc/portage/make.conf &&
sed -i --debug "s/#SCCACHE_MAX_FRAME_LENGTH/SCCACHE_MAX_FRAME_LENGTH/g" /etc/portage/make.conf &&
echo -e "\e[32m\n/etc/portage/make.conf\n-----------------------------------------------------\e[0m";
cat /etc/portage/make.conf;
echo -e "\e[32m-----------------------------------------------------\e[0m";

echo -e "\n\e[32m==> Step 9 of 13: \e[0mTo update the @world set\n"; sleep 1
emerge --verbose --update --deep --newuse @world;
etc-update --automode -3;
emerge --verbose --update --deep --newuse @world &&
etc-update --automode -3;
env-update;
source /etc/profile;
export PS1="(chroot) ${PS1}";

echo -e "\n\e[32m==> Step 10 of 13: \e[0mTo To set the timezone and configure locates\n"; sleep 1
echo "Asia/Shanghai" > /etc/timezone &&
emerge --config sys-libs/timezone-data &&
nano /etc/locale.gen &&
locale-gen &&
eselect locale set C &&
env-update;
etc-update;
source /etc/profile;
export PS1="(chroot) ${PS1}";

echo -e "\n\e[32m==> Step 11 of 13: \e[0mTo install firmware\n"; sleep 1
emerge sys-kernel/linux-firmware;

echo -e "\n\e[32m==> Step 12 of 13: \e[0mTo install Distribution kernel\n"; sleep 1
echo "sys-kernel/installkernel dracut" >> /etc/portage/package.use/installkernel &&
emerge sys-kernel/gentoo-kernel-bin &&

echo -e "\n\e[32m==> Step 13 of 13: \e[0mTo run 'ls /lib/modules'\n"; sleep 1
ls -alhF --color /lib/modules