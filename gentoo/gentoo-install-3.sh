#!/bin/bash
set -e

echo -e "-----------------------------------------------------"
echo -e "|                   \e[1mtascscripts\e[0m                     |"
echo -e "|        Copyright 2024 Tarikko-ScetayhChan         |"
echo -e "|https://github.com/Tarikko-ScetayhChan/tascscripts/|"
echo -e "-----------------------------------------------------"
echo -e "-----------------------------------------------------"
echo -e "|                gentoo-install-3.sh                |"
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

echo -e "\n    \e[32m==> Step 2: \e[0mTo update the @world set\n"; sleep 1
emerge --verbose --update --deep --newuse @world;
etc-update &&
emerge --verbose --update --deep --newuse @world &&

echo -e "\n    \e[32m==> Step 3: \e[0mTo To set the timezone and configure locates\n"; sleep 1
echo "Asia/Shanghai" > /etc/timezone &&
emerge --config sys-libs/timezone-data &&
nano /etc/locale.gen &&
locale-gen &&
eselect locale set C &&
env-update &&
source /etc/profile &&