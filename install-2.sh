#!/bin/bash

## compiler: ssc-0.0.1-b4
## host: Darwin YupyeSortaco.local 24.0.0 Darwin Kernel Version 24.0.0: Mon Aug 12 21:27:51 PDT 2024; root:xnu-11215.1.10~5/RELEASE_ARM64_T8112 arm64 arm Darwin
## date: 20240831T160331Z

#!/bin/bash

set -e

## include >>>
Print256Colors () 
{ 
    for gis_functions_Print256Colors_fgbg in 38 48;
    do
        for gis_functions_Print256Colors_color in {0..255};
        do
            printf "\e[${gis_functions_Print256Colors_fgbg};5;%sm  %3s  \e[0m" $gis_functions_Print256Colors_color $gis_functions_Print256Colors_color;
            if [[ $((($gis_functions_Print256Colors_color + 1) % 6)) == 4 ]]; then
                echo;
            fi;
        done;
    done;
    echo;
    sleep 3
}
PrintBrand () 
{ 
    echo;
    echo -e " _______________________________________________________________";
    echo -e "|                  gentoo-installation-scripts                  |";
    echo -e "| <github.com/Tarikko-ScetayhChan/gentoo-installation-scripts>  |";
    echo -e "|                                                               |";
    echo -e "|              Copyright 2024 Tarikko-ScetayhChan               |";
    echo -e "|                  <weychon_lyon@outlook.com>                   |";
    echo -e "|                   <tarikko-scetayhchan.top>                   |";
    echo -e "|===============================================================|";
    echo -en "|";
    blankAside=$[ ( 63 - ${#1} ) / 2 ];
    for ((i=1; i<=${blankAside}; i++))
    do
        echo -en " ";
    done;
    echo -en "$1";
    for ((i=1; i<=${blankAside}; i++))
    do
        echo -en " ";
    done;
    if [[ $[ ${#1} % 2 ] == 0 ]]; then
        echo -en " ";
    else
        echo -en "";
    fi;
    echo -e "|";
    echo -e "|===============================================================|";
    echo -e "|                                                               |";
    echo -e "| This file is part of gentoo-installation-scripts.             |";
    echo -e "|                                                               |";
    echo -e "| gentoo-installation-scripts is free software: you can         |";
    echo -e "| redistribute it and/or modify it under the terms of the GNU   |";
    echo -e "| General Public License as published by the Free Software      |";
    echo -e "| Foundation, either version 3 of the License, or (at your      |";
    echo -e "| option) any later version.                                    |";
    echo -e "|                                                               |";
    echo -e "| gentoo-installation-scripts is distributed in the hope that   |";
    echo -e "| it will be useful, but WITHOUT ANY WARRANTY; without even the |";
    echo -e "| implied warranty of MERCHANTABILITY or FITNESS FOR A          |";
    echo -e "| PARTICULAR PURPOSE. See the GNU General Public License for    |";
    echo -e "| more details.                                                 |";
    echo -e "|                                                               |";
    echo -e "| You should have received a copy of the GNU General Public     |";
    echo -e "| License along with gentoo-installation-scripts. If not, see   |";
    echo -e "| <https://www.gnu.org/licenses/>.                              |";
    echo -e "|                                                               |";
    echo -e "|_______________________________________________________________|";
    echo;
    sleep 3
}
PrintStep () 
{ 
    echo -e "\n\e[32m==> Step $1 of $2: \e[0m$3\n";
    sleep 1
}
PrintStepNumber () 
{ 
    echo -e " \e[032m*\e[0m Total step(s): \e[1m\e[093m$1\e[0m";
    sleep 3
}
PrintStepOff () 
{ 
    echo;
    echo -en " \e[032m<<<\e[0m Ended step: (\e[93m$1\e[0m of \e[93m$2\e[0m) \e[92m$3\e[0m ($(date))";
    sleep 0.5;
    echo
}
PrintStepOn () 
{ 
    echo;
    echo -e " \e[032m>>>\e[0m Started step: (\e[93m$1\e[0m of \e[93m$2\e[0m) \e[92m$3\e[0m ($(date))";
    sleep 0.5;
    echo
}
RemindConfiguration () 
{ 
    echo -e " \e[093m*\e[0m Edit the configuration before running the script.";
    echo;
    sleep 3
}
Slibs_PrintMessage () 
{ 
    echo -n "$1: ";
    [[ "$2" = d* ]] && echo -en "\e[1m\e[037mdebug: \e[0m";
    [[ "$2" = i* ]] && echo -en "\e[1m\e[092minfo: \e[0m";
    [[ "$2" = w* ]] && echo -en "\e[1m\e[093mwarning: \e[0m";
    [[ "$2" = e* ]] && echo -en "\e[1m\e[091merror: \e[0m";
    [[ "$2" = f* ]] && echo -en "\e[1m\e[031mfafal: \e[0m";
    echo "$3"
}
Slibs_PrintMessage_Debug () 
{ 
    Slibs_PrintMessage "$1" d "$2"
}
Slibs_PrintMessage_Error () 
{ 
    Slibs_PrintMessage "$1" e "$2"
}
Slibs_PrintMessage_Fafal () 
{ 
    Slibs_PrintMessage "$1" f "$2"
}
Slibs_PrintMessage_Fafal_InvalidExtensionName () 
{ 
    Slibs_PrintMessage_Fafal "$1" "Invalid extension name in \`$2'."
}
Slibs_PrintMessage_Fafal_ItemExists () 
{ 
    Slibs_PrintMessage_Fafal "$1" "\`$2' exists."
}
Slibs_PrintMessage_Fafal_ItemNotFound () 
{ 
    Slibs_PrintMessage_Fafal "$1" "\`$2' not found."
}
Slibs_PrintMessage_Fafal_SourceExpected () 
{ 
    Slibs_PrintMessage_Fafal "$1" "Source expected."
}
Slibs_PrintMessage_Fafal_TargetExpected () 
{ 
    Slibs_PrintMessage_Fafal "$1" "Target expected."
}
Slibs_PrintMessage_Fafal_TooManyArguments () 
{ 
    Slibs_PrintMessage_Fafal "$1" "To many arguments."
}
Slibs_PrintMessage_Info () 
{ 
    Slibs_PrintMessage "$1" i "$2"
}
Slibs_PrintMessage_Warning () 
{ 
    Slibs_PrintMessage "$1" w "$2"
}
Ssc_WriteCompilationInformation () 
{ 
    echo "$ssc_compilationInfo" >> "$ssc_target"
}
WaitForRegret () 
{ 
    echo -en " \e[093m*\e[0m Starting in: ";
    sleep 1;
    echo -en "\b";
    gis_functions_WaitForRegret_i=5;
    until [[ ${gis_functions_WaitForRegret_i} == 0 ]]; do
        echo -en " \e[91m${gis_functions_WaitForRegret_i}\e[0m";
        gis_functions_WaitForRegret_i=$((${gis_functions_WaitForRegret_i}-1));
        sleep 1;
    done;
    echo
}
## <<<


PrintBrand $0
RemindConfiguration
WaitForRegret

PrintStepOn 1 26 "To load settings"
source /etc/profile
export PS1="(chroot) ${PS1}"
PrintStepOff 1 26 "To load settings"

PrintStepOn 2 26 "To install the latest snapshot"
rm -rf -v /var/db/repos/gentoo/metadata/timestamp.x
emerge-webrsync
if [ ${gis_install_whetherToRunEmergeSync} != no ]; then
    emerge --sync
fi
PrintStepOff 2 26 "To install the latest snapshot"

PrintStepOn 3 26 "To deploy 'make.conf'"
mv /etc/portage/make.conf{,.bak}
cp make.conf /etc/portage/
PrintStepOff 3 26 "To deploy 'make.conf'"

PrintStepOn 4 26 "To install cpuid2cpuflags'"
emerge cpuid2cpuflags
PrintStepOff 4 26 "To install cpuid2cpuflags'"

PrintStepOn 5 26 "To run 'cpuid2cpuflags'"
cpuid2cpuflags
echo "*/* $(cpuid2cpuflags)" > /etc/portage/package.use/00cpu-flags
PrintStepOff 5 26 "To run 'cpuid2cpuflags'"

PrintStepOn 6 26 "To install ccache and aria2"
emerge ccache aria2
PrintStepOff 6 26 "To install ccache and aria2"

PrintStepOn 7 26 "To configure ccache and aria2"
sed -i "s/#FETCHCOMMAND/FETCHCOMMAND/g" /etc/portage/make.conf
sed -i "s/#RESUMECOMMAND/RESUMECOMMAND/g" /etc/portage/make.conf
sed -i "s/#FEATURES/FEATURES/g" /etc/portage/make.conf
sed -i "s/#CCACHE_DIR/CCACHE_DIR/g" /etc/portage/make.conf
PrintStepOff 7 26 "To configure ccache and aria2"

PrintStepOn 8 26 "To update the @world set"
emerge --verbose --update --deep --newuse @world
etc-update --automode -3
emerge --verbose --update --deep --newuse @world
etc-update --automode -3
env-update
source /etc/profile
export PS1="(chroot) ${PS1}"
PrintStepOff 8 26 "To update the @world set"

PrintStepOn 9 26 "To set the timezone and configure locates"
echo "Asia/Shanghai" > /etc/timezone
emerge --config sys-libs/timezone-data
sed -i "s/#en_US/en_US/g" /etc/locale.gen
locale-gen
eselect locale set C
env-update
etc-update
source /etc/profile
export PS1="(chroot) ${PS1}"
PrintStepOff 9 26 "To set the timezone and configure locates"

PrintStepOn 10 26 "To install firmware"
emerge sys-kernel/linux-firmware
PrintStepOff 10 26 "To install firmware"

PrintStepOn 11 26 "To install distribution kernel"
echo "sys-kernel/installkernel dracut" >> /etc/portage/package.use/installkernel
emerge sys-kernel/gentoo-kernel-bin
PrintStepOff 11 26 "To install distribution kernel"

PrintStepOn 12 26 "To create the fstab file"
emerge genfstab
genfstab -U / >> /etc/fstab
PrintStepOff 12 26 "To create the fstab file"

PrintStepOn 13 26 "To set the hostname"
echo "${gis_install_hostname}" > /etc/hostname
PrintStepOff 13 26 "To set the hostname"

PrintStepOn 14 26 "To set hosts"
echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1	localhost" >> /etc/hosts
echo "127.0.1.1	${gis_install_hostname}.localdomain	${gis_install_hostname}" >> /etc/hosts
PrintStepOff 14 26 "To set hosts"

PrintStepOn 15 26 "To install dhcpcd"
emerge net-misc/dhcpcd
PrintStepOff 15 26 "To install dhcpcd"

PrintStepOn 16 26 "To enable dhcpcd service"
rc-update add dhcpcd default
PrintStepOff 16 26 "To enable dhcpcd service"

PrintStepOn 17 26 "To install sudo"
emerge app-admin/sudo
PrintStepOff 17 26 "To install sudo"

PrintStepOn 18 26 "To configure sudo"
sed -i "s/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/g" /etc/sudoers
PrintStepOff 18 26 "To configure sudo"

PrintStepOn 19 26 "To install system tools and extra packages"
emerge app-admin/sysklogd sys-process/cronie sys-apps/mlocate app-shells/bash-completion net-misc/chrony sys-fs/xfsprogs sys-fs/e2fsprogs sys-fs/dosfstools sys-fs/btrfs-progs sys-fs/zfs sys-fs/jfsutils sys-fs/dosfstools net-misc/ntp net-dialup/ppp net-wireless/iw net-wireless/wpa_supplicant ${gis_install_extraPackages}
PrintStepOff 19 26 "To install system tools and extra packages"

PrintStepOn 20 26 "To enable system tool services"
rc-update add ntp-client default
ntpdate -b -u 0.gentoo.pool.ntp.org
rc-update add ntpd default
rc-update add sysklogd default 
rc-update add cronie default
rc-update add sshd default
rc-update add chronyd default
PrintStepOff 20 26 "To enable system tool services"

PrintStepOn 21 26 "To add a user for daily use"
useradd -m -G audio,cdrom,floppy,portage,usb,video,wheel ${gis_install_newUserUsername}
PrintStepOff 21 26 "To add a user for daily use"

PrintStepOn 22 26 "To install grub"
emerge sys-boot/grub
PrintStepOff 22 26 "To install grub"

PrintStepOn 23 26 "To install bootloader"
grub-install --target=${gis_install_grubInstallTarget} --efi-directory=/boot/efi --bootloader-id=${gis_install_bootloaderId}
PrintStepOff 23 26 "To install bootloader"

PrintStepOn 24 26 "To generate grub configuration"
grub-mkconfig -o /boot/grub/grub.cfg
PrintStepOff 24 26 "To generate grub configuration"

PrintStepOn 25 26 "To set the root password"
passwd
PrintStepOff 25 26 "To set the root password"

PrintStepOn 26 26 "To set the new user password"
passwd ${gis_install_newUserUsername}
PrintStepOff 26 26 "To set the new user password"