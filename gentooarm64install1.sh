#!/bin/sh

####### gentooarm64install1.sh

##### Read and edit this script before you chmod +x and run it.

##### run commands below before turning to ssh:
##### 	passwd
##### 	/etc/init.d/sshd start
##### 	ifconfig

### network setup
	net-setup &&
	nano -w /etc/resolv.conf &&

### partition the disk
# Check if your disk is /dev/nvme0n1p1.
# partition 1	2 GB	fat32
# partition 2	8 GB	ext4
# partition 3	2 GB	swap
# partition 4	surplus	ext4
	cfdisk /dev/nvme0n1 &&
	fdisk /dev/nvme0n1 &&

### mkfs partitions and swapfile
	mkfs.fat -F 32 /dev/nvme0n1p1 &&
	mkfs.ext4 /dev/nvme0n1p2 &&
	mkswap /dev/nvme0n1p3 &&
	mkfs.ext4 /dev/nvme0n1p4 &&
# Uncomment the command below if you want to create a swapfile.
	#fallocate -l 8G /mnt/gentoo/swapfile &&
	#chmod 600 /mnt/gentoo/swapfile &&
	#mkswap /mnt/gentoo/swapfile &&

### mount partitions and swapfile
	mount /dev/nvme0n1p4 --mkdir /mnt/gentoo &&
	mount /dev/nvme0n1p2 --mkdir /mnt/gentoo/boot &&
	mount /dev/nvme0n1p1 --mkdir /mnt/gentoo/boot/efi &&
	swapon /dev/nvme0n1p3 &&
# Uncomment the command below if you want to create a swapfile.
	#swapon /mnt/gentoo/swapfile &&

### deploy stage 3 autobuild
	cd /mnt/gentoo &&
	links https://mirrors.ustc.edu.cn/gentoo/releases/arm64/autobuilds/current-stage3-arm64-openrc/ &&
	tar xpvf *.tar.xz --xattrs-include='*.*' --numeric-owner &&
	hwclock --systohc ;
	mv /mnt/gentoo/etc/portage/make.conf{,.bak} ;
# Remember to click on the box in front of the website address to select it.
	mirrorselect -i -o >> /mnt/gentoo/etc/portage/make.conf ;
	mkdir -p -v /mnt/gentoo/etc/portage/repos.conf &&
	cp -v /mnt/gentoo/usr/share/portage/config/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf &&
	mv /mnt/gentoo/etc/portage/repos.conf/gentoo.conf{,.bak} ;
	sed 's/rsync.gentoo.org/rsync.mirrors.ustc.edu.cn/g' /mnt/gentoo/etc/portage/repos.conf/gentoo.conf.bak >> /mnt/gentoo/etc/portage/repos.conf/gentoo.conf ;
	cp --dereference /etc/resolv.conf /mnt/gentoo/etc/ &&

### write necessary configuration to /mnt/gentoo/root/.bashrc
	echo "export PS1='(chroot) \[\033]0;\u@\h:\w\007\]\[\033[01;31m\]\h\[\033[01;34m\] \w \$\[\033[00m\] '" >> /mnt/gentoo/root/.bashrc ;
	echo "alias l='ls -ahl --color'" >> /mnt/gentoo/root/.bashrc ;
	echo "alias n='neofetch | lolcat'" >> /mnt/gentoo/root/.bashrc ;
	echo "alias v='nano ~/.bashrc && source ~/.bashrc'" >> /mnt/gentoo/root/.bashrc ;
	echo "alias c='nano /etc/portage/make.conf'" >> /mnt/gentoo/root/.bashrc ;

### mount file systems
	mount --types proc /proc /mnt/gentoo/proc &&
	mount --rbind /sys /mnt/gentoo/sys &&
	mount --make-rslave /mnt/gentoo/sys &&
	mount --rbind /dev /mnt/gentoo/dev &&
	mount --make-rslave /mnt/gentoo/dev &&
	mount --bind /run /mnt/gentoo/run &&
	mount --make-slave /mnt/gentoo/run &&


### chroot
	chroot /mnt/gentoo /bin/bash
