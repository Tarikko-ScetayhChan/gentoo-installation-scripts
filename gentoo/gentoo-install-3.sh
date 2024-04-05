#!/bin/bash

set -e

echo -e "-----------------------------------------------------\n|                   \e[1mtascscripts\e[0m                     |\n|        Copyright 2024 Tarikko-ScetayhChan         |\n|https://github.com/Tarikko-ScetayhChan/tascscripts/|\n-----------------------------------------------------\n-----------------------------------------------------\n|                gentoo-install-3.sh                |\n-----------------------------------------------------\nThis file is part of tascscripts.\ntascscripts is free software: you can redistribute it\nand/or modify it under the terms of the GNU General\nPublic License as published by the Free Software\nFoundation, either version 3 of the License, or (at\nyour option) any later version.\ntascscripts is distributed in the hope that it will\nbe useful, but WITHOUT ANY WARRANTY; without even the\nimplied warranty of MERCHANTABILITY or FITNESS FOR A\nPARTICULAR PURPOSE. See the GNU General Public\nLicense for more details.\nYou should have received a copy of the GNU General\nPublic License along with tascscripts. If not, see\n<https://www.gnu.org/licenses/>.\n"; sleep 5

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

echo -e "\n\e[32m==> Step 1 of TOTAL: \e[0mTo set the environment variables\n"; sleep 1
export PATH_SCRIPTS_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" &&
source ${PATH_SCRIPTS_ROOT}/env/gentoo-install-env-1.conf &&

echo -e "\n\e[32m==> Step 2 of TOTAL: \e[0mTo update the @world set\n"; sleep 1
etc-update;
emerge --verbose --update --deep --newuse @world;
etc-update;
emerge --verbose --update --deep --newuse @world &&

echo -e "\n\e[32m==> Step 3 of TOTAL: \e[0mTo To set the timezone and configure locates\n"; sleep 1
echo "Asia/Shanghai" > /etc/timezone &&
emerge --config sys-libs/timezone-data &&
nano /etc/locale.gen &&
locale-gen &&
eselect locale set C &&
env-update &&
source /etc/profile &&