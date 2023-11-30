#!/bin/bash

#添加用户环境变量
PATH=$PATH:~/.config/nvim-linux64/bin

alias vim=nvim
alias vi=nvim
alias ll='ls -a -l'
alias rmake='"make"'
alias make='bear --append -- make'

#启动fastgithub代理
function fastgit_on()
{
    export http_proxy="http://127.0.0.1:38457"
    export https_proxy="http://127.0.0.1:38457"
    ~/.config/fastgithub_start.sh &
    echo 'fastgithub已启动'
}
function fastgit_off()
{
    killall fastgithub
    unset http_proxy
    unset https_proxy
    echo 'fastgithub已关闭'
}

#vim使用google翻译
function google_translator_vim()
{
    export google_translator_vim='google_translator_vim'
}
function google_translator_vim_off()
{
    unset google_translator_vim
}
google_translator_vim   #默认打开google翻译

#使用外部代理,外部翻墙即可
function proxy_on()
{
    wsl2ip=$(cat /etc/resolv.conf | grep 'nameserver' | cut -f 2 -d ' ')
    export http_proxy="http://$wsl2ip:7890"
    export https_proxy=$http_proxy
    google_translator_vim
    #export all_proxy=socks5://127.0.0.1:7890 # or this line
    echo -e "已开启代理"
}
function proxy_off()
{
    unset http_proxy
    unset https_proxy
    google_translator_vim_off
    echo -e "已关闭代理"
}

#esp32的idf所需要的编译工具默认路径在~/.espressif,可以设置IDF_TOOLS_PATH修改
#需要在运行idf的终端窗口运行 ". $IDF_PATH/export.sh"
function set_esp32_env()
{
    export ADF_PATH=~/tools/esp-adf
    . $ADF_PATH/esp-idf/export.sh
}
#当esp32发生崩溃时在32esp_addr2line后跟崩溃指针将展示调用堆栈
alias 32esp_addr2line='xtensa-esp32-elf-addr2line -pfiaC -e build/*.elf '

#将终端配置\w改为\W,绝对路径->当前路径：\u 显示username,\h 显示hosename, \W 显示当前目录
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u:\[\033[01;34m\]\W\[\033[00m\]\$ '

function out_bmake()
{
    param1=$1
    param2=$2
    if [ "$param1" == "clean" ]; then
        bear --append -- make build/obj/apps/$param2/_clean
    else
        bear --append -- make build/obj/apps/$param1/_compile && bear --append -- make build/obj/apps/$param1/_install
    fi
}

function cdroot()
{
    cur=`pwd`
    while true
    do 
        for file in `la .`
        do 
            if [ ".git" == $file ]
            then
                #echo root="$file"
                cd $cur
                cd -
                return
            fi
        done
        cd ..
        if [ "/" == `pwd` ]
        then
            #echo "not file .git"
            cd $cur
            return
        fi
    done
}

function uttelnet()
{
    param1=$1
    timestamp=$(date +%s)

    /home/user/.config/nvim/tools/script/expect_telnet.sh $param1 | tee -a /tmp/$1_$timestamp.log
}

function vimtl()
{
    /home/user/.config/nvim/tools/script/expect_vimtl.sh
}
function vimtr()
{
    /home/user/.config/nvim/tools/script/expect_vimtr.sh
}
alias vimt=vimtl
alias vimtt=vimtl

function set_mi30_env()
{
    export PATH=$PATH:/usr/local/comtom_toolchain/mi30x/arm-linux-gnueabihf/bin/
}

function set_self_libs_env()
{
    cur=`pwd`
    ulimit -c 1024000
    echo "已配置自己动态库目录环境,开启coredump,生成coredump文件在这里:"
    cat /proc/sys/kernel/core_pattern
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$cur/build/install/lib:$cur/build/install/lib64:$cur/build/libs
}

#GitHub删除某个文件及其提交历史记录
function git_delete_file()
{
    param1=$1
    echo "GitHub删除某个文件及其提交历史记录:"$param1
    # 删除包括历史
    git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch '$param1 \
        --prune-empty --tag-name-filter cat -- --all
    # 同步到远程
    echo "同步到远程仓库,执行:git push origin master --force"
    git push origin master --force
}

#mi30的gdb遍历脚本工具
function mgdb()
{
    /home/user/.config/nvim/tools/script/expect_mi30_gdb.sh $1 $2 $3 $4 $5
}
