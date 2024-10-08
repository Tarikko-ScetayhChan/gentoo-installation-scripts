#!/bin/bash

##include {
source functions
##}

PrintBrand $0
WaitForRegret

PrintStepOn 1 2 "To unmount file systems"
cd
swapoff /mnt/gentoo/swapfile
umount -l /mnt/gentoo/dev{/shm,/pts,}
umount -lR /mnt/gentoo
PrintStepOff 1 2 "To unmount file systems"

PrintStepOn 2 2 "To reboot the system"
reboot
PrintStepOff 2 2 "To reboot the system"