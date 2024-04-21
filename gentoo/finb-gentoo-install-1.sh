#!/bin/bash

echo
FINB_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
echo -e "[\e[32mInfo\e[0m] Located the finb path (FINB_PATH=${FINB_PATH})."

echo
FINB_CURRENT_SCRIPT=`basename "$0"`
echo -e "[\e[32mInfo\e[0m] Gotten the current script name (FINB_CURRENT_SCRIPT=${FINB_CURRENT_SCRIPT})."

echo
source ${FINB_PATH}/core/finb.loadcore

# 加载脚本配置

# 检查变量

finb.scripthead ${FINB_CURRENT_SCRIPT}
sleep 3

finb.msg.conf
sleep 3
echo

finb.msg.regret
echo

