#!/bin/sh
# 绝对地址， 项目路径
P_PUBLIC_PATH=$(pwd)
# log文件
P_LOGFILE="$P_PUBLIC_PATH/logs/access.log"
# pid文件
P_PID_FILE="$P_PUBLIC_PATH/logs/webhook.pid"
# 启动json文件
P_HOOK_FILE="$P_PUBLIC_PATH/hooks.json"

# start 启动参数
P_START_PARAMS="-hooks $P_HOOK_FILE -hotreload -logfile $P_LOGFILE -pidfile $P_PID_FILE"

# 调试开关 0： 关闭
P_DEBUG="0"
if [ $P_DEBUG -eq "1" ]
  then
  P_START_PARAMS="$P_START_PARAMS -debug -verbose"
fi
