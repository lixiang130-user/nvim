#!/bin/bash

#添加用户环境变量
PATH=$PATH:~/.user_tools/nvim-linux64/bin

alias vim=nvim
alias vi=nvim
alias ll='ls -a -l'
alias bmake='bear --append -- make'

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
    unset https_proxy
    echo 'fastgithub已关闭'
}

#esp32的idf所需要的编译工具默认路径在~/.espressif,可以设置IDF_TOOLS_PATH修改
#需要在运行idf的终端窗口运行 ". $IDF_PATH/export.sh"
function set_esp32_env()
{
    export ADF_PATH=~/tools/esp-adf
    . $ADF_PATH/esp-idf/export.sh
}

#将终端配置\w改为\W,绝对路径->当前路径：\u 显示username,\h 显示hosename, \W 显示当前目录
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u:\[\033[01;34m\]\W\[\033[00m\]\$ '

function set_call_station_path()
{
    export MI30_V3S_TOOLCHAIN_PATH=~/tools/comtom_toolchain/mi30x/arm-linux-gnueabihf
    export PATH=$PATH:$MI30_V3S_TOOLCHAIN_PATH/bin:$MI30_V3S_TOOLCHAIN_PATH
}
