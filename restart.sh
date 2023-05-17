#!/bin/bash
# 拿到脚本路径，避免其他位置执行脚本时相对路径问题
cd $(dirname $0)
echo $(pwd)
source ./config.sh;
PID=""

if [ -f "$P_PID_FILE" ]
    then
    PID=$(cat $P_PID_FILE);
fi

if [[ -n "$PID" ]]
  then
   echo "restart $PID"
  kill -HUP $PID &
fi