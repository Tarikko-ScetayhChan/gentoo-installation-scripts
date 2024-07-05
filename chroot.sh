#!/bin/bash

set -e

export gis_chroot_efiPartition=/dev/nvme0n1p1
export gis_chroot_bootPartition=/dev/nvme0n1p2
export gis_chroot_swapPartition=/dev/nvme0n1p3
export gis_chroot_rootPartition=/dev/nvme0n1p4

mount -v ${gis_chroot_rootPartition} --mkdir /mnt/gentoo
mount -v ${gis_chroot_bootPartition} --mkdir /mnt/gentoo/boot
mount -v ${gis_chroot_efiPartition} --mkdir /mnt/gentoo/boot/efi
swapon -v ${gis_chroot_swapPartition}

swapon -v /mnt/gentoo/swapfile

mount -v --types proc /proc /mnt/gentoo/proc
mount -v --rbind /sys /mnt/gentoo/sys
mount -v --make-rslave /mnt/gentoo/sys
mount -v --rbind /dev /mnt/gentoo/dev
mount -v --make-rslave /mnt/gentoo/dev
mount -v --bind /run /mnt/gentoo/run
mount -v --make-slave /mnt/gentoo/run

chroot /mnt/gentoo /bin/bash