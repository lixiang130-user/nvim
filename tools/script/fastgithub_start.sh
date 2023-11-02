#!/bin/bash
#启动github代理服务
ps -ef | grep "fastgithub_linux-x64/fastgithub" | grep -v "grep" > /tmp/fastgithub.log
if [[ $? != 0 ]]; then
    ~/.config/fastgithub_linux-x64/fastgithub > ~/.config/fastgithub_linux-x64/log.log &
fi
