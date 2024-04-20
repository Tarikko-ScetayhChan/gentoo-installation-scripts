#!/bin/bash

echo
FINB_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
echo -e "[\e[32mInfo\e[0m] Located the finb path (FINB_PATH=${FINB_PATH})."
sleep 1

echo
FINB_CURRENT_SCRIPT=`basename "$0"`
echo -e "[\e[32mInfo\e[0m] Gotten the current script name (FINB_CURRENT_SCRIPT=${FINB_CURRENT_SCRIPT})."
sleep 1

echo
source ${FINB_PATH}/core/finb.loadcore
sleep 1

# 加载脚本配置

finb.scripthead ${FINB_CURRENT_SCRIPT}
sleep 1

# 检查变量