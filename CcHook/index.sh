#!/bin/bash
# 当前脚本执行环境是项目根目录，与其他项目引入路径不一样
source ./config.sh;

git fetch --all
git checkout --force "origin/main"
echo "checkout success"
./restart.sh

echo "CcHook update and restart"