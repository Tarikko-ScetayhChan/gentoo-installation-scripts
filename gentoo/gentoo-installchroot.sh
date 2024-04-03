#!/bin/bash

echo -e "-----------------------------------------------------"
echo -e "|                   \e[1mtascscripts\e[0m                     |"
echo -e "|        Copyright 2024 Tarikko-ScetayhChan         |"
echo -e "|https://github.com/Tarikko-ScetayhChan/tascscripts/|"
echo -e "-----------------------------------------------------"
echo -e "-----------------------------------------------------"
echo -e "|                gentoo-install1.sh                 |"
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

echo -e "\e[32mInfo: \e[0mThe set environment variables are:"
export path_efi_parition=/dev/nvme0n1p1
export path_boot_parition=/dev/nvme0n1p2
export path_swap_parition=/dev/nvme0n1p3
export path_root_parition=/dev/nvme0n1p4
echo -e "    path_efi_parition=${path_efi_parition}"
echo -e "    path_boot_parition=${path_boot_parition}"
echo -e "    path_swap_parition=${path_swap_parition}"
echo -e "    path_root_parition=${path_root_parition}"

mount ${path_root_parition} --mkdir /mnt/gentoo &&
mount ${path_boot_parition} --mkdir /mnt/gentoo/boot &&
mount ${path_efi_parition} --mkdir /mnt/gentoo/boot/efi &&
swapon ${path_swap_parition} &&
swapon /mnt/gentoo/swapfile &&
mount --types proc /proc /mnt/gentoo/proc &&
mount --rbind /sys /mnt/gentoo/sys &&
mount --make-rslave /mnt/gentoo/sys &&
mount --rbind /dev /mnt/gentoo/dev &&
mount --make-rslave /mnt/gentoo/dev &&
mount --bind /run /mnt/gentoo/run &&
mount --make-slave /mnt/gentoo/run &&
chroot /mnt/gentoo /bin/bash