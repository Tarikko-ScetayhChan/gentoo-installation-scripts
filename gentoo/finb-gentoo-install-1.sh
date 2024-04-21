#!/bin/bash

# locate finb path
echo
FINB_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
echo -e "[\e[032mInfo\e[0m] Located the finb path (FINB_PATH=${FINB_PATH})."

# get current script name
echo
FINB_GENTOO_CURRENT_SCRIPT=`basename "$0"`
echo -e "[\e[032mInfo\e[0m] Gotten the current script name (FINB_GENTOO_CURRENT_SCRIPT=${FINB_GENTOO_CURRENT_SCRIPT})."

# load finb core
echo
chmod +x ${FINB_PATH}/core/*
source ${FINB_PATH}/core/finb.loadcore

# load script configuration
echo
source ${0%/*}/conf/*
FINB_GENTOO_TOTAL_STEP=114514
FINB_GENTOO_CURRENT_STEP=0
finb.msg info "Loaded the script configuration."

# check variables

# print scripthead
finb.scripthead ${FINB_GENTOO_CURRENT_SCRIPT}
sleep 3

# set and print total number of steps
finb.msg.settotalstep ${FINB_GENTOO_TOTAL_STEP}
sleep 3
echo

# remind to edit configuration
finb.msg.conf
sleep 3
echo

# wait 5 seconds for regret
finb.msg.regret

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