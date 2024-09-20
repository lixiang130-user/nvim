#!/bin/bash

#添加用户环境变量
PATH=$PATH:~/.config/nvim-linux64/bin

alias vim=vim_proxy
alias vi=nvim
alias ll='ls -a -l'
alias rmake='"make"'
alias make='make_fun'
alias rrm='"rm" -rf'
alias rm='rm_fun'
#alias make='bear --append -- make'

#bash进入vi模式,set -o可以查看值,-o配置键位,+o 设置值
alias vibash_on='set -o vi'
alias vibash_off='set +o vi off && set -o emacs'

alias cdtrash='cd $user_trash_dir ; echo `pwd`'
alias cdcode_win='cd /mnt/c/Users/13097/Desktop/code ; echo `pwd`'
alias cdnvim='cd ~/.config/nvim ; echo `pwd`'
alias cdwork='cd ~/linux/work ; echo `pwd`'
alias cduser='cd ~/linux/user ; echo `pwd`'
alias cdtemp='cd ~/linux/temp ; echo `pwd`'
alias cdmytools='cd ~/linux/user/mytools ; echo `pwd`'
alias cdscript='cd ~/.config/nvim/tools/script ; echo `pwd`'
alias vimuser_tools='cd ~/.config/nvim/tools/script ; vim user_tools.sh'
alias vimnvim='cd ~/.config/nvim/ ; vim init.lua'
alias cd20='cd ~/linux/work/20 ; echo `pwd`'
alias cd80='cd ~/linux/work/80 ; echo `pwd`'
alias cd81='cd ~/linux/work/81 ; echo `pwd`'
alias cdsdk='cd ~/linux/work/sdk ; echo `pwd`'
alias cdtongzhou_transportation='cd ~/linux/work/tongzhou_transportation ; echo `pwd`'
alias cdkernel='cd ~/linux/work/kernel ; echo `pwd`'

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

    open_proxy=`env | grep "http_proxy"`
    if [[ "$open_proxy" != "" ]]
    then
        proxy_off
    fi

    if [ "$param1" == "clean" ]; then
        bear --append -- make build/obj/apps/$param2/_clean
    else
        bear --append -- make build/obj/apps/$param1/_compile && bear --append -- make build/obj/apps/$param1/_install
    fi

    if [[ "$open_proxy" != "" ]]
    then
        proxy_on
    fi
}

function cdroot()
{
    cur=`pwd`
    while true
    do 
        for file in `la .`
        do 
            if [ ".git" == $file ] && [ -d "$file" ]    #文件名叫".git"且是文件夹
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
function set_mi30_env_app()
{
    export PATH=$PATH:/usr/local/comtom_toolchain/mi30x/arm-linux-gnueabihf/bin/
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
function gdb_mi30()
{
    echo "gdb app coredump"
    #~/.config/nvim/tools/script/expect/expect_mi30_gdb.sh $1 $2 $3 $4 $5
    ~/.config/nvim/tools/script/expect/expect_mi30_gdb.sh $@
}

function vim_proxy()
{
    proxy_on
    #nvim $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10}
    #$@表示所有参数!!!
    nvim $@
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
    if [[ $param1 == "reprepare" ]]
    then
        bear --append -- make reprepare
        bear --append -- make prepare
    else
        #bear --append -- make $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10}
        bear --append -- make $@
    fi
    ret=$?
    if [[ "$open_proxy" != "" ]]
    then
        proxy_on
    fi

    if [[ $param1 == "clean" ]]
    then
        rm ./compile_commands.json
        rm -rf ./.cache > /dev/null
    fi
    if [[ $param1 == "clean_all" ]]
    then
        rm ./compile_commands.json
    fi
    return $ret
}

function git_submodule_sync()
{
    echo "git submodule update --init --recursive"
    git submodule update --init --recursive
}

function rg_replace()
{
    #望远镜查找字符串使用rg工具,会尊重.gitignore,这里修改成不尊重的方式
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

function utf8_encode_files()
{
    #将当前目录下的所有.c.h.cpp转换成utf8编码格式
    ~/.config/nvim/tools/script/python/file_to_utf8.py
}

user_trash_name=.trash
user_trash_dir=~/$user_trash_name
function rm_fun()
{
    if [ ! -d "$user_trash_dir" ]; then
        mkdir -p "$user_trash_dir"
    fi
    cur=`pwd`
    # =~ 用于正则表达式匹配. (/.*)? 表示可选的零个或多个字符，用斜杠分隔。
    if [[ $cur =~ ^${user_trash_dir}(/.*)?$ ]]; then
        rrm $@
        return $?
    fi

    files_to_trash=()
    for arg in "$@"; do
        case $arg in
            -f|-r|-rf|-fr)
                # 忽略这些选项
                ;;
            *)
                # 将文件添加到垃圾箱列表
                files_to_trash+=("$arg")
                ;;
        esac
    done

    # 将文件移至垃圾箱, ${FILES_TO_TRASH[@]} 是一个 Bash 语法，用于引用数组中的所有元素
    # 如果数组包含三个元素 "file1.txt", "file2.txt", "file3.txt"，那么 ${FILES_TO_TRASH[@]} 会被扩展为 file1.txt file2.txt file3.txt。
    for file in "${files_to_trash[@]}"; do
        if [ -e "$file" ]; then
            if [[ $file =~ ^${user_trash_name}(/.*)?$ ]]; then
                echo "清空回收站 成功"
                rrm $@
                return $?
            else
                if [ -e "$user_trash_dir/$(basename "$file")" ]; then
                    #echo "回收站存在同名文件夹,删除回收站中的同名文件夹,移动到回收站成功!rrm "$user_trash_dir/$(basename "$file")""
                    rrm "$user_trash_dir/$(basename "$file")"
                fi
                mv "$file" "$user_trash_dir/"
            fi
            #echo "moved to trash: $file"
        else
            echo "rm(trash): cannot remove '$file': no such file or directory"
        fi
    done
}
function clear_trash()
{
    rrm $user_trash_dir
    echo "已清空回收站"
}

#精简path环境变量,加快tab补全和其他指令速度
function path_simplify()
{
    # 获取当前 PATH 并转换成数组
    IFS=':' read -r -a path_array <<< "$PATH"
    # 新的 PATH 数组
    new_path_array=()
    # 去除重复路径和/mnt下的path
    declare -A seen_paths
    for path in "${path_array[@]}"; do
        if [[ -z "${seen_paths[$path]}" && "$path" != /mnt/* ]]; then
            seen_paths[$path]=1
            new_path_array+=("$path")
        fi
    done
    # 保留部分常用的 Windows 指令所在的路径
    new_path_array+=("/mnt/c/Windows")
    new_path_array+=("/mnt/c/Windows/system32")
    # 重新设置 PATH
    new_path="${new_path_array[*]}"
    new_path="${new_path// /:}"

    #echo "旧的 PATH: $PATH"
    export PATH="$new_path"
    #echo "新的 PATH: $PATH"
}

function adb()
{
    echo "/mnt/d/Program\ Files/platform-tools/adb.exe $@"
    timestamp=$(date +%s)
    /mnt/d/Program\ Files/platform-tools/adb.exe $@ | tee -a /tmp/adb_$timestamp.log
}

###########################默认启动执行程序#############################
#google_translator_vim_on   #默认打开google翻译
#proxy_on    #开启了代理能google翻译了
path_simplify
