#!/bin/bash

#添加用户环境变量
PATH=$PATH:~/.user_tools/nvim-linux64/bin

alias vim=nvim
alias vi=nvim
alias ll='ls -a -l'
alias bmake='bear --append -- make'

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

#vim使用google翻译
function google_translator_vim()
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
    #git submodule init
    #git submodule update
    module=$1
    bmake build/obj/apps/$module/_compile && bmake build/obj/apps/$module/_install
}

function all_out_bmake()
{
    sudo ls && make prepare2 && make version_ctrl && bmake all -j32 && bmake -j32 \
        && bmake apps && bmake libs && bmake install && make image && make upgrade
}

function mount_server_lixiang()
{
    #smbmount需要root权限，挂载后只有root有读写权限。
    #需要设置uid和pid为本机使用者的uid和gid, dir_mode 和 file_mode需要设置为0777
    #cat /etc/passwd|grep user 查看用户uid和gid方法
    sudo mount -t cifs "//192.168.111.21/lixiang" "/home/user/samba/"\
        -o username="lixiang",password="123456",uid=1000,gid=1000,iocharset=utf8,rw,dir_mode=0777,file_mode=0777
}

