#!/bin/bash
set -e

echo -e "-----------------------------------------------------"
echo -e "|                   \e[1mtascscripts\e[0m                     |"
echo -e "|        Copyright 2024 Tarikko-ScetayhChan         |"
echo -e "|https://github.com/Tarikko-ScetayhChan/tascscripts/|"
echo -e "-----------------------------------------------------"
echo -e "-----------------------------------------------------"
echo -e "|                gentoo-install-2.sh                |"
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

echo -e "\e[33mWarning: \e[0mEdit 'make.conf' before running this script.\n"
sleep 5

echo -e "\e[33mWarning: \e[0mYou will have 5 seconds to cancel this\nscript."
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

echo -e "\n    \e[32m==> Step 1: \e[0mTo set the environment variables\n"; sleep 1
export PATH_SCRIPTS_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" &&
source ${PATH_SCRIPTS_ROOT}/env/gentoo-install-env-1.conf &&

echo -e "\n    \e[32m==> Step 2: \e[0mTo load settings\n"; sleep 1
source /etc/profile &&
export PS1="(chroot) ${PS1}" &&

echo -e "\n    \e[32m==> Step 3: \e[0mTo install the latest snapshot\n"; sleep 1
rm -f /var/db/repos/gentoo/metadata/timestamp.x;
emerge-webrsync &&
emerge --sync;

echo -e "\n    \e[32m==> Step 4: \e[0mTo copy 'make.conf'\n"; sleep 1
mv -v /etc/portage/make.conf{,.bak}
cp -v ${PATH_SCRIPTS_ROOT}/gentoo-makedotconf.txt /mnt/gentoo/etc/portage/make.conf;

echo -e "\n    \e[32m==> Step 5: \e[0mTo install ccache and aria2\n"; sleep 1
emerge ccache aria2 sccache