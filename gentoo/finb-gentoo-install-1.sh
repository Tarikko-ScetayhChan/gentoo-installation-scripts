#!/bin/zsh

### debug

if [[ $1 == "--debug" ]]; then
    readonly finb_gentoo_debug=yes
fi

### head

readonly finb_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo -e " \e[032m*\e[0m Located finb path: \e[1m\e[093m${finb_path}\e[0m"

if [[ -f "${finb_path}/core/finb.core.loadCore" ]]; then
    chmod +x ${finb_path}/core/*
    source ${finb_path}/core/finb.core.loadCore
else
    echo -e " \e[091m*\e[0m Failed to load core: \e[1m\e[093m${finb_path}/core/finb.core.loadCore\e[0m"
    echo -e " \e[091m*\e[0m You should download finb again and check MD5 sum!"
    time
    exit 1
fi

if [ -f "${finb_path}/gentoo/conf/finb-gentoo-install.conf" ]; then
    source ${finb_path}/gentoo/conf/finb-gentoo-install.conf
    echo -e " \e[032m*\e[0m Loaded configuration: \e[1m\e[093m${finb_path}/gentoo/conf/finb-gentoo-install.conf\e[0m."
elif [[ ${finb_gentoo_debug} == "yes" ]]; then
    echo -e " \e[032m*\e[0m Debugging; skipped to load configuration."
else
    echo -e " \e[091m*\e[0m Failed to load configuration: \e[1m\e[093m${finb_path}/gentoo/conf/finb-gentoo-install.conf\e[0m"
    echo -e " \e[091m*\e[0m You should download finb again and check MD5 sum!"
    source finb.core.exit 1
fi

### check variables

### introduction

if [[ ${finb_gentoo_debug} == "yes" ]]; then
    source finb.core.print256Colors
fi

echo; source finb.core.printBrand `basename "$0"`; sleep 3; echo

if [[ ${finb_gentoo_debug} == "yes" ]]; then
    readonly finb_gentoo_totalStep=9999
else
    readonly finb_gentoo_totalStep=
fi
source finb.core.printTotalStep ${finb_gentoo_totalStep}
sleep 3

source finb.core.remindConf
sleep 3

source finb.core.regret

### steps