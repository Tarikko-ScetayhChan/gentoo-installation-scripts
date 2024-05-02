#!/bin/bash

# locate finb path
echo
finbPath="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
echo -e " \e[032m*\e[0m Gotten the finb path \e[1m\e[093m${finbPath}\e[0m."

# get current script name
echo
finbGentooScriptName=`basename "$0"`
echo -e " \e[032m*\e[0m Gotten the script name \e[1m\e[093m${finbGentooScriptName}\e[0m."

# load finb core
echo
chmod +x ${finbPath}/core/*
source ${finbPath}/core/finb.core.loadCore

# load script configuration
echo
if [ -f "${0%/*}/conf/finb-gentoo-install.conf" ]
then
    source ${0%/*}/conf/finb-gentoo-install.conf
    finbGentooTotalStep=114514
    finbGentooCurrentStep=0
    echo -e " \e[032m*\e[0m Loaded the configuration \e[1m\e[093m${0%/*}/conf/finb-gentoo-install.conf\e[0m."
else
    echo -e " \e[091m*\e[0m Cannot find the configuration \e[1m\e[093m${0%/*}/conf/finb-gentoo-install.conf\e[0m! You need to download finb again and check the MD5 sum!"
    exit 1
fi

# check variables

# print scripthead
finb.core.printBrand ${finbGentooScriptName}

finb.core.printTotalStep ${finbGentooTotalStep}

# remind to edit configuration
finb.core.remindConf

# wait 5 seconds for regret
finb.core.regret

#################################################################

((FINB_GENTOO_CURRENT_STEP=${FINB_GENTOO_CURRENT_STEP}+1))
finb.step on ${FINB_GENTOO_CURRENT_STEP} ${FINB_GENTOO_TOTAL_STEP} net "To configure the network"

until 
    if [[ ${FINB_GENTOO_NETWORK_CONNECTION_METHOD} == "net-setup" ]] 
    then
        net-setup
        sleep 1
    elif [[ ${FINB_GENTOO_NETWORK_CONNECTION_METHOD} == "wpa_supplicant" ]] 
    then
       wpa_supplicant -D wext -B -i ${FINB_GENTOO_NETWORK_CONNECTION_WPA_SUPPLICANT_DEVICE} -c <(wpa_passphrase ${FINB_GENTOO_NETWORK_CONNECTION_WPA_SUPPLICANT_WLANNAME} ${FINB_GENTOO_NETWORK_CONNECTION_WPA_SUPPLICANT_PASSWORD})
       sleep 1
    elif [[ ${FINB_GENTOO_NETWORK_CONNECTION_METHOD} == "custom" ]] 
    then
      bash ${FINB_GENTOO_NETWORK_CONNECTION_CUSTOM_COMMAND}
      sleep 1
    elif [[ ${FINB_GENTOO_NETWORK_CONNECTION_METHOD} == "skip" ]] 
    then
       finb.msg info "Skipped network connection."
       sleep 1
       echo
    fi
    ping -c ${FINB_GENTOO_NETWORK_CONNECTION_TEST_TIMES} ${FINB_GENTOO_NETWORK_CONNECTION_TEST_DOMAIN}
do
    finb.msg info "Network connected."
    echo
done

finb.step off ${FINB_GENTOO_CURRENT_STEP} ${FINB_GENTOO_TOTAL_STEP} net "To configure the network"

#################################################################

((FINB_GENTOO_CURRENT_STEP=${FINB_GENTOO_CURRENT_STEP}+1))
finb.step on ${FINB_GENTOO_CURRENT_STEP} ${FINB_GENTOO_TOTAL_STEP} dns "To configure the DNS"

finb.gentoo.chdns ${FINB_GENTOO_DNS}

finb.step off ${FINB_GENTOO_CURRENT_STEP} ${FINB_GENTOO_TOTAL_STEP} dns "To configure the DNS"

#################################################################

((FINB_GENTOO_CURRENT_STEP=${FINB_GENTOO_CURRENT_STEP}+1))
finb.step on ${FINB_GENTOO_CURRENT_STEP} ${FINB_GENTOO_TOTAL_STEP} disk "To partition the disk, mkfs and mount"

if [[ ${FINB_GENTOO_DISK_PARTITON_AND_MKFS_METHOD} == "auto" ]]
then
    echo -e "g\nn\n1\n\n+1G\nt\n1\nn\n2\n\n+1G\nn\n3\n\n+4G\nn\n4\n\n\nw" | fdisk ${FINB_GENTOO_DISK_PARTITON_AND_MKFS_DISK}
    mkfs.fat -F 32 ${FINB_GENTOO_DISK_PARTITON_AND_MKFS_DISK}p1
    mkfs.ext4 ${FINB_GENTOO_DISK_PARTITON_AND_MKFS_DISK}p2
    mkswap ${FINB_GENTOO_DISK_PARTITON_AND_MKFS_DISK}p3
    mkfs.xfs ${FINB_GENTOO_DISK_PARTITON_AND_MKFS_DISK}p4
    mount -v ${path_root_parition} --mkdir /mnt/gentoo
    mount -v ${path_boot_parition} --mkdir /mnt/gentoo/boot
    mount -v ${path_efi_parition} --mkdir /mnt/gentoo/boot/efi
    swapon -v ${path_swap_parition}
fi