#!/bin/sh

	####### gentoo-arm64-install3.sh
	####### https://github.com/Tarikko-ScetayhChan/tascscripts/

	##### Read and edit this script before chmod +x and run it.

	##### Run this script after exiting the chrooting.

	### reboot
cd ;
umount -l /mnt/gentoo/dev{/shm,/pts,} ;
umount -R /mnt/gentoo ;
reboot