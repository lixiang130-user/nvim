#!/bin/bash

#添加用户环境变量
PATH=$PATH:~/.config/nvim-linux64/bin

alias vim=nvim
#alias vi=nvim
alias vi=vim_proxy
alias ll='ls -a -l'
alias rmake='"make"'
alias make='make_fun'
#alias make='bear --append -- make'

#bash进入vi模式,set -o可以查看值,-o配置键位,+o 设置值
alias vibash_on='set -o vi'
alias vibash_off='set +o vi off && set -o emacs'

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
function google_translator_vim_on()
{
    export google_translator_vim='google_translator_vim'
}
function google_translator_vim_off()
{
    unset google_translator_vim
}

#使用外部代理,外部翻墙即可
function proxy_on()
{
    wsl2ip=$(cat /etc/resolv.conf | grep 'nameserver' | cut -f 2 -d ' ')
    wsl2ip='192.168.222.222'    #后来这样才行了,用windows的ip地址,有时间时改成python解析ipconfig.exe返回值的方式
    export http_proxy="http://$wsl2ip:7890"
    export https_proxy=$http_proxy
    #export all_proxy=socks5://127.0.0.1:7890 # or this line
    #echo -e "已开启代理"
}
function proxy_off()
{
    unset http_proxy
    unset https_proxy
    google_translator_vim_off
    #echo -e "已关闭代理"
}

#esp32的idf所需要的编译工具默认路径在~/.espressif,可以设置IDF_TOOLS_PATH修改
#需要在运行idf的终端窗口运行 ". $IDF_PATH/export.sh"
function set_esp32_env()
{
    param1=$1
    esp_path="/usr/local/comtom_toolchain/esp"

    if [ "$param1" == "1" ]; then
        export ADF_PATH=$esp_path"/esp-adf"
        . $ADF_PATH/esp-idf/export.sh
    else
        export IDF_TOOLS_PATH=$esp_path"/espressif"
        sh_path=$esp_path"/esp-idf/export.sh"
        . $sh_path
    fi
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
    result=$(echo $param1 | grep "\.")
    if [[ $param1 == *.*.*.* ]]; then   #通配符判断字符串
        ip=$param1
    elif [[ "$result" != "" ]]; then    #grep 判断字符串包含
        ip=192.168.$param1
    else
        ip=192.168.222.$param1
    fi
    #echo "result:$result ip:$ip"
    ~/.config/nvim/tools/script/expect/expect_telnet.sh $ip | tee -a /tmp/$1_$timestamp.log
}

function vimtl()
{
    ~/.config/nvim/tools/script/expect/expect_vimtl.sh
}
function vimtr()
{
    ~/.config/nvim/tools/script/expect/expect_vimtr.sh
}
alias vimt=vimtr
alias vimtt=vimtr

function set_mi30_env()
{
    #export PATH=$PATH:/usr/local/comtom_toolchain/mi30x/arm-linux-gnueabihf/bin/
    source /usr/local/comtom_toolchain/mi30x/arm-linux-gnueabihf_sdk/comtom-crosstool-env-init-sdk
}
function set_mi20_env()
{
    source /usr/local/comtom_toolchain/mi20x/arm_linux_4.8/nuvoton-crosstool-env-init-comtom
}
function set_ssc337_env()
{
    export PATH=$PATH:/usr/local/comtom_toolchain/ssc337/bin/
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
    ~/.config/nvim/tools/script/expect/expect_mi30_gdb.sh $1 $2 $3 $4 $5
}

function vim_proxy()
{
    proxy_on
    nvim $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10}
    proxy_off
}

function make_fun()
{
    ret=0
    param1=$1
    open_proxy=`env | grep "http_proxy"`
    if [[ "$open_proxy" != "" ]]
    then
        proxy_off
    fi
    bear --append -- make $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10}
    ret=$?
    if [[ "$open_proxy" != "" ]]
    then
        proxy_on
    fi
    if [[ $param1 == "clean" ]]
    then
        rm ./compile_commands.json
    fi
    return $ret
}

function git_submodule_sync()
{
    git submodule update --init --recursive
}

function rg_replace()
{#望远镜查找字符串使用rg工具,会尊重.gitignore,这里修改成不尊重的方式
    cd ~/.config/nvim/tools/script/ && ./rg.py user_replace && cd -
}
function rg_recover()
{
    cd ~/.config/nvim/tools/script/ && ./rg.py user_recover && cd -
}

function utssh()
{
    param1=$1
    if [[ "$param1" == "" ]]; then    #grep 判断字符串包含
        param1="lixiang"
    fi
    timestamp=$(date +%s)
    addr=$param1@192.168.111.21
    echo "addr:$addr"
    ~/.config/nvim/tools/script/expect/expect_ssh.sh $addr | tee -a /tmp/$1_$timestamp.log
}

function utscp()
{
    param1=$1
    src=$2
    dst=$2
    timestamp=$(date +%s)
    addr=$param1@192.168.111.21:
    echo "addr:$addr"
    ~/.config/nvim/tools/script/expect/expect_scp.sh $addr $src $dst
}

function bc_reset()
{
    cd ~/.config/nvim/tools/auto_install/
    ./auto_install.py bc
    cd -
}

###########################默认启动执行程序#############################
#google_translator_vim_on   #默认打开google翻译
#proxy_on    #开启了代理能google翻译了
