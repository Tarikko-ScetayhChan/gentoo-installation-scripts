#!/bin/bash

set -e

echo -e "-----------------------------------------------------\n|                   \e[1mtascscripts\e[0m                     |\n|        Copyright 2024 Tarikko-ScetayhChan         |\n|https://github.com/Tarikko-ScetayhChan/tascscripts/|\n-----------------------------------------------------\n-----------------------------------------------------\n|              gentoo-install-chroot.sh             |\n-----------------------------------------------------\nThis file is part of tascscripts.\ntascscripts is free software: you can redistribute it\nand/or modify it under the terms of the GNU General\nPublic License as published by the Free Software\nFoundation, either version 3 of the License, or (at\nyour option) any later version.\ntascscripts is distributed in the hope that it will\nbe useful, but WITHOUT ANY WARRANTY; without even the\nimplied warranty of MERCHANTABILITY or FITNESS FOR A\nPARTICULAR PURPOSE. See the GNU General Public\nLicense for more details.\nYou should have received a copy of the GNU General\nPublic License along with tascscripts. If not, see\n<https://www.gnu.org/licenses/>.\n"

export path_efi_parition=/dev/nvme0n1p1
export path_boot_parition=/dev/nvme0n1p2
export path_swap_parition=/dev/nvme0n1p3
export path_root_parition=/dev/nvme0n1p4

mount -v ${path_root_parition} --mkdir /mnt/gentoo &&
mount -v ${path_boot_parition} --mkdir /mnt/gentoo/boot &&
mount -v ${path_efi_parition} --mkdir /mnt/gentoo/boot/efi &&
swapon -v ${path_swap_parition} &&
swapon -v /mnt/gentoo/swapfile &&
mount -v --types proc /proc /mnt/gentoo/proc &&
mount -v --rbind /sys /mnt/gentoo/sys &&
mount -v --make-rslave /mnt/gentoo/sys &&
mount -v --rbind /dev /mnt/gentoo/dev &&
mount -v --make-rslave /mnt/gentoo/dev &&
mount -v --bind /run /mnt/gentoo/run &&
mount -v --make-slave /mnt/gentoo/run &&
chroot /mnt/gentoo /bin/bash