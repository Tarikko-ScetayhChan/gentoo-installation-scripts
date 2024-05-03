#!/bin/bash

finb_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
echo -e " \e[032m*\e[0m Located finb path: \e[1m\e[093m${finb_path}\e[0m"

if [ -f "${finb_path}/core/finb.core.loadCore" ]
then
    source ${finb_path}/core/finb.core.loadCore
    echo -e " \e[032m*\e[0m Loaded core: \e[1m\e[093m${finb_path}/core/finb.core.loadCore\e[0m"
else
    echo -e " \e[091m*\e[0m Failed to load core: \e[1m\e[093m${finb_path}/gentoo/conf/finb-gentoo-install.conf\e[0m"
    echo -e " \e[091m*\e[0m You should download finb again and check MD5 sum!"
    exit 1
fi

if [ -f "${finb_path}/gentoo/conf/finb-gentoo-install.conf" ]
then
    source ${finb_path}/gentoo/conf/finb-gentoo-install.conf
    echo -e " \e[032m*\e[0m Loaded configuration: \e[1m\e[093m${finb_path}/gentoo/conf/finb-gentoo-install.conf\e[0m."
else
    echo -e " \e[091m*\e[0m Failed to load configuration: \e[1m\e[093m${finb_path}/gentoo/conf/finb-gentoo-install.conf\e[0m"
    echo -e " \e[091m*\e[0m You should download finb again and check MD5 sum!"
    exit 1
fi

# check variables

finb.core.printBrand `basename "$0"`

finb_gentoo_totalStep=114514
finb.core.printTotalStep ${finb_gentoo_totalStep}

finb.core.remindConf

finb.core.regret