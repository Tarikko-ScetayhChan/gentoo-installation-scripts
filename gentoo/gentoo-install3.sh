#!/bin/bash

echo -e "-----------------------------------------------------"
echo -e "|                   \e[1mtascscripts\e[0m                     |"
echo -e "|        Copyright 2024 Tarikko-ScetayhChan         |"
echo -e "|https://github.com/Tarikko-ScetayhChan/tascscripts/|"
echo -e "-----------------------------------------------------"
echo -e "-----------------------------------------------------"
echo -e "|                gentoo-install3.sh                 |"
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

echo
echo -e "    \e[32m==> Step 1: \e[0mTo reboot"
echo
cd ;
umount -l /mnt/gentoo/dev{/shm,/pts,} ;
umount -R /mnt/gentoo ;
reboot