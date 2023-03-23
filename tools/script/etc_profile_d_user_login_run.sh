#!/bin/bash

#添加用户环境变量
PATH=$PATH:~/.user_tools/nvim-linux64/bin

if false; then
    #使用外部代理,外部翻墙即可
    wsl2ip=$(cat /etc/resolv.conf | grep 'nameserver' | cut -f 2 -d ' ')
    export https_proxy="http://$wsl2ip:7890"
    export http_proxy="http://$wsl2ip:7890"
    export all_proxy="socks5://$wsl2ip:7890"
    #echo 'use windows proxy'
elif true; then
#使用外部代理,外部翻墙即可
function proxy_on()
{
    wsl2ip=$(cat /etc/resolv.conf | grep 'nameserver' | cut -f 2 -d ' ')
    export http_proxy="http://$wsl2ip:7890"
    export https_proxy=$http_proxy
    #export all_proxy=socks5://127.0.0.1:7890 # or this line
    echo -e "已开启代理"
}

function proxy_off()
{
    unset http_proxy
    unset https_proxy
    echo -e "已关闭代理"
}

#启动fastgithub代理
function fastgit_on()
{
    export http_proxy="http://127.0.0.1:38457"
    export https_proxy="http://127.0.0.1:38457"
    ~/.user_tools/fastgithub_start.sh &
    echo 'fastgithub已启动'
}
function fastgit_off()
{
    killall fastgithub
    unset http_proxy
    unset https_porxy
    echo 'fastgithub已关闭'
}
fi

