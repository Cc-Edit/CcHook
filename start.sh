#!/bin/bash
# 拿到脚本路径，避免其他位置执行脚本时相对路径问题
cd $(dirname $0)
echo $(pwd)

source ./config.sh;
chmod u+x ./*.sh
P_CMD="$P_PUBLIC_PATH/webhook/webhook $P_START_PARAMS"
echo $P_CMD
$P_CMD &