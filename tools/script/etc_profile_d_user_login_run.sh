#!/bin/bash

#添加用户环境变量
PATH=$PATH:~/.user_tools/nvim-linux64/bin

#启动fastgithub代理
if false; then
    export http_proxy="http://127.0.0.1:38457"
    export https_proxy="http://127.0.0.1:38457"
    ~/.user_tools/user_tools_start.sh &
    #echo 'use fastgithub'
elif true; then
    #使用外部代理,外部翻墙即可
    wsl2ip=$(cat /etc/resolv.conf | grep 'nameserver' | cut -f 2 -d ' ')
    export https_proxy="http://$wsl2ip:7890"
    export http_proxy="http://$wsl2ip:7890"
    export all_proxy="socks5://$wsl2ip:7890"
    #echo 'use windows proxy'
fi
