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

PrintStepOn 1 18 "net-setup"
if [ ${gis_install_whetherToRunNetsetup} != no ]; then
    net-setup
fi
PrintStepOff 1 18 "net-setup"

PrintStepOn 2 18 "To replace nameserver in '/etc/resolv.conf'"
sed -i "s|nameserver.*|nameserver ${gis_install_nameserver}|g" /etc/resolv.conf
PrintStepOff 2 18 "To replace nameserver in '/etc/resolv.conf'"

PrintStepOn 3 18 "To generate the fdisk script"
mkdir -v tmp
echo -e "g\nn\n1\n\n+${gis_install_efiPartitionSize}\nt\n1\nn\n2\n\n+${gis_install_bootPartitionSize}\nn\n3\n\n+${gis_install_swapPartitionSize}\nn\n4\n\n\nw" > tmp/gentoo-install-fdisk.txt
PrintStepOff 3 18 "To generate the fdisk script"

PrintStepOn 4 18 "To partition the disk"
cat tmp/gentoo-install-fdisk.txt | fdisk ${gis_install_disk}
PrintStepOff 4 18 "To partition the disk"

PrintStepOn 5 18 "To create file systems"
mkfs.fat -F 32 ${gis_install_efiPartition}
mkfs.${gis_install_bootPartitionFs} ${gis_install_bootPartition}
mkswap ${gis_install_swapPartition}
mkfs.${gis_install_rootPartitionFs} ${gis_install_rootPartition}
PrintStepOff 5 18 "To create file systems"

PrintStepOn 6 18 "To mount file systems"
mount -v ${gis_install_rootPartition} --mkdir /mnt/gentoo
mount -v ${gis_install_bootPartition} --mkdir /mnt/gentoo/boot
mount -v ${gis_install_efiPartition} --mkdir /mnt/gentoo/boot/efi
swapon -v ${gis_install_swapPartition}
PrintStepOff 6 18 "To mount file systems"

PrintStepOn 7 18 "To create swapfile"
fallocate -l ${gis_install_swapfileSize} -v /mnt/gentoo/swapfile
chmod 600 /mnt/gentoo/swapfile
mkswap /mnt/gentoo/swapfile
PrintStepOff 7 18 "To create swapfile"

PrintStepOn 8 18 "To mount swapfile"
swapon /mnt/gentoo/swapfile
PrintStepOff 8 18 "To mount swapfile"

PrintStepOn 9 18 "To set the date and the time"
hwclock -v --systohc
date
PrintStepOff 9 18 "To set the date and the time"

PrintStepOn 10 18 "To enter '/mnt/gentoo'"
export gis_install_originalDirectory=$(pwd)
cd /mnt/gentoo
pwd
PrintStepOff 10 18 "To enter '/mnt/gentoo'"

PrintStepOn 11 18 "To download the stage file"
${gis_install_stage3DownloadTool} ${gis_install_stage3DownloadAddress}
PrintStepOff 11 18 "To download the stage file"

PrintStepOn 12 18 "To extract the stage file"
tar xpvf *.tar.xz --xattrs-include='*.*' --numeric-owner
PrintStepOff 12 18 "To extract the stage file"

PrintStepOn 13 18 "To copy the Gentoo repository configuration file"
mkdir -pv /mnt/gentoo/etc/portage/repos.conf
cp -v /mnt/gentoo/usr/share/portage/config/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf
PrintStepOff 13 18 "To copy the Gentoo repository configuration file"

PrintStepOn 14 18 "To replace the sync-uri variable"
sed -i "s|rsync:\/\/rsync.gentoo.org\/gentoo-portage|${gis_install_rsyncAddress}|g" /mnt/gentoo/etc/portage/repos.conf/gentoo.conf
PrintStepOff 14 18 "To replace the sync-uri variable"

PrintStepOn 15 18 "To copy DNS info"
cp -v --dereference /etc/resolv.conf /mnt/gentoo/etc/
PrintStepOff 15 18 "To copy DNS info"

PrintStepOn 16 18 "To mount the necessary filesystems"
mount -v --types proc /proc /mnt/gentoo/proc
mount -v --rbind /sys /mnt/gentoo/sys
mount -v --make-rslave /mnt/gentoo/sys
mount -v --rbind /dev /mnt/gentoo/dev
mount -v --make-rslave /mnt/gentoo/dev
mount -v --bind /run /mnt/gentoo/run
mount -v --make-slave /mnt/gentoo/run
PrintStepOff 16 18 "To mount the necessary filesystems"

PrintStepOn 17 18 "To copy scripts into the new root"
cd ${gis_install_originalDirectory}
mkdir -pv /mnt/gentoo/gentoo-installation-scripts
cp -rv ./* /mnt/gentoo/gentoo-installation-scripts/
PrintStepOff 17 18 "To copy scripts into the new root"

PrintStepOn 18 18 "To enter the new environment"
chroot /mnt/gentoo /bin/bash
PrintStepOff 18 18 "To enter the new environment"