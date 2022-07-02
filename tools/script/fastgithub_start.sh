#!/bin/bash
#启动github代理服务
ps -ef | grep "fastgithub_linux-x64/fastgithub" | grep -v "grep" > /tmp/fastgithub.log
if [[ $? != 0 ]]; then
    ~/.user_tools/fastgithub_linux-x64/fastgithub > ~/.user_tools/fastgithub_linux-x64/log.log &
fi
