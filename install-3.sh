#!/bin/bash

## compiler: ssc-0.0.1-b4
## host: Darwin YupyeSortaco.local 24.0.0 Darwin Kernel Version 24.0.0: Mon Aug 12 21:27:51 PDT 2024; root:xnu-11215.1.10~5/RELEASE_ARM64_T8112 arm64 arm Darwin
## date: 20240831T160331Z

#!/bin/bash

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