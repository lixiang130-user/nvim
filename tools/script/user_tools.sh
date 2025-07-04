#!/bin/bash

#添加用户环境变量
PATH=$PATH:~/.config/nvim-linux64/bin
#添加go环境
PATH=$(go env GOPATH)/bin:$PATH

#将终端配置\w改为\W,绝对路径->当前路径：\u 显示username,\h 显示hosename, \W 显示当前目录
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u:\[\033[01;34m\]\W\[\033[00m\]\$ '

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
alias viminitVim='cd ~/.config/nvim/ ; vim init.lua'
alias cd20='cd ~/linux/work/20 ; echo `pwd`'
alias cd80='cd ~/linux/work/80 ; echo `pwd`'
alias cd81='cd ~/linux/work/81 ; echo `pwd`'
alias cdsdk='cd ~/linux/work/sdk ; echo `pwd`'
alias cdtongzhou_transportation='cd ~/linux/work/tongzhou_transportation ; echo `pwd`'
alias cdkernel='cd ~/linux/work/kernel ; echo `pwd`'
alias vimgitnote='cd ~/linux/user/mytools/note_for_all/git ; vim note_git.txt'
alias cdbase='cd ~/linux/user/mytools/base ; echo `pwd`'
alias vimbase='cd ~/linux/user/mytools/base ; vim'
alias vimauto_install='cd ~/.config/nvim/tools/auto_install ; vim auto_install.py'
alias cdauto_install='cd ~/.config/nvim/tools/auto_install ; echo `pwd`'

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
    # 使用 Python 脚本获取 Windows 的 IP 地址
    # 缩进敏感,不要自动对齐
    wsl2ip=$(python3 -c "
import subprocess
import re

def get_windows_ip():
    # 执行 ipconfig.exe 并读取输出，使用 gbk 编码避免 UnicodeDecodeError
    result = subprocess.run(['ipconfig.exe'], stdout=subprocess.PIPE, text=True, encoding='gbk')
    match = re.search(r'IPv4 地址[. ]*[:]*[ ]*(\d+\.\d+\.\d+\.\d+)', result.stdout)
    if match:
        return match.group(1)
    return None

print(get_windows_ip())")

    # 如果成功获取到 IP 地址，设置代理
    if [[ -n "$wsl2ip" ]]; then
        #以前老版本的方案
        #wsl2ip=$(cat /etc/resolv.conf | grep 'nameserver' | cut -f 2 -d ' ')
        #wsl2ip='192.168.222.222'    #后来这样才行了,用windows的ip地址,有时间时改成python解析ipconfig.exe返回值的方式
        export http_proxy="http://$wsl2ip:7890"
        export https_proxy=$http_proxy
        #echo -e "已开启代理，使用 Windows IP: $wsl2ip"
    else
        echo -e "开启代理失败,未能获取到 Windows IP 地址"
    fi
    #sudo apt-get 使用代理的方式
    #sudo apt-get \
    #    -o Acquire::ForceIPv4=true \
    #    -o Acquire::http::Proxy="http://192.168.222.222:7890" \
    #    -o Acquire::https::Proxy="http://192.168.222.222:7890" \
    #    update

}
function proxy_off()
{
    unset http_proxy
    unset https_proxy
    google_translator_vim_off
    #echo -e "已关闭代理"
}

function go_proxy_on()
{
    #go下载代码等的代理
    export GOPROXY=https://goproxy.cn,direct
}
function go_proxy_off()
{
    unset GOPROXY
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

function out_bmake()
{
    param1=$1
    param2=$2

    open_proxy=`env | grep "http_proxy"`

    if [[ "$open_proxy" != "" ]]; then
        proxy_off
    fi

    if [[ "$param1" == "clean" ]]; then
        echo "bear --append -- make build/obj/apps/$param2/_clean"
        bear --append -- make build/obj/apps/$param2/_clean
    elif [[ "$param1" == *"/"* ]]; then
        # 如果param1包含路径，则直接使用param1路径
        echo "bear --append -- make $param1/_compile && bear --append -- make $param1/_install"
        bear --append -- make $param1/_compile && bear --append -- make $param1/_install
    else
        # 否则继续使用默认路径
        echo "bear --append -- make build/obj/apps/$param1/_compile && bear --append -- make build/obj/apps/$param1/_install"
        bear --append -- make build/obj/apps/$param1/_compile && bear --append -- make build/obj/apps/$param1/_install
    fi

    if [[ "$open_proxy" != "" ]]; then
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

function v3s_uttelnet()
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
    ~/.config/nvim/tools/script/expect/expect_telnet_v3s.sh $ip | tee -a /tmp/$1_$timestamp.log
}

function vimtl()
{
    ~/.config/nvim/tools/script/expect/expect_vimtl.sh
}
function vimtr()
{
    ~/.config/nvim/tools/script/expect/expect_vimtr.sh
}
function vimt()
{
    ~/.config/nvim/tools/script/expect/expect_vimt.sh
}

function set_mi30_env_sdk_old()
{
    #export PATH=$PATH:/usr/local/comtom_toolchain/mi30x/arm-linux-gnueabihf/bin/
    source /usr/local/comtom_toolchain/mi30x/arm-linux-gnueabihf_sdk/comtom-crosstool-env-init-sdk
}
function set_mi30_env()
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
function set_mg21x_env()
{
    cd /usr/local/comtom_toolchain/mg21x/arm_linux_4.9.broadmobi_sdk && source bm_sdk/environment-setup-armv7a-vfp-neon-oe-linux-gnueabi-comtom && cd - > /dev/null
}
function set_t113_kernel_env()
{
    timestamp=$(date +%s)
    docker run -v /home/user/linux/:/home/user/linux  -w "$(pwd)" -it t113_ubuntu1404 /bin/sh --login | tee -a /tmp/t113_$timestamp.log
    #-c "source build/envsetup.sh; exec bash
}

function git_show_big_file()
{
    git rev-list --all | xargs -rL1 git ls-tree -r --long | sort -uk3 | sort -rnk4
}
#GitHub删除某个文件及其提交历史记录
function git_delete_file()
{
    param1=$1
    echo "GitHub删除某个文件及其提交历史记录:"$param1
    # 删除包括历史
    #git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch '$param1 \
    #    --prune-empty --tag-name-filter cat -- --all
    #sudo apt install git-filter-repo  # 部分版本可能不支持
    git remote -v
    git filter-repo --path "$param1" --invert-paths
    # 同步到远程
    echo "同步到远程仓库,请执行(若失败则不是在git根目录调用的本功能指令):"
    echo "先关联远端仓库:"
    echo "git remote add origin <远程仓库URL>"
    echo "同步所有分支所有tag:"
    echo "git push origin --force --all"
    echo "git push origin --force --tags"
    echo "git push origin master --force"
    git push origin master --force
}

#mi30的gdb遍历脚本工具
function gdb_mi30()
{
    echo "gdb app coredump"
    #~/.config/nvim/tools/script/expect/expect_mi30_gdb.sh $1 $2 $3 $4 $5
    ~/.config/nvim/tools/script/expect/expect_mi30_gdb.sh $@
}
#t113的gdb遍历脚本工具
function gdb_t113()
{
    echo "gdb app coredump"
    ~/.config/nvim/tools/script/expect/expect_t113_gdb.sh $@
}

function vim_proxy()
{
    vimd $@
    return
    proxy_on
    nvim "$@"
    proxy_off
}

function vimd()
{
    proxy_on

    # 如果 nvim_code 不存在，则复制 nvim 到 nvim_code
    if [ ! -f ~/.config/nvim-linux64/bin/nvim_code ]; then
        cp ~/.config/nvim-linux64/bin/nvim ~/.config/nvim-linux64/bin/nvim_code
    fi

    #$@表示所有参数!!!
    if [ $# -eq 0 ]; then
        nvim_code "$@"
        #~/.config/nvim/tools/script/expect/expect_nvim.sh
    else
        nvim "$@"
    fi
    proxy_off
}

function vimm()
{
    proxy_on

    # 如果 nvim_code 不存在，则复制 nvim 到 nvim_code
    if [ ! -f ~/.config/nvim-linux64/bin/nvim_code ]; then
        cp ~/.config/nvim-linux64/bin/nvim ~/.config/nvim-linux64/bin/nvim_code
    fi

    #nvim $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10}
    #$@表示所有参数!!!
    # 使用所有传入的参数运行 nvim_code
    if [ $# -eq 0 ]; then
        #nvim_code "$@"
        ~/.config/nvim/tools/script/expect/expect_nvim.sh
    else
        nvim "$@"
    fi
    proxy_off
}


function make_fun()
{
    ret=0
    param1=$1

    # 获取当前目录的最后一部分名
    current_dir_name=${PWD##*/}
    # 判断是否是 "mytools"
    if [ "$current_dir_name" = "mytools" ]; then
        cd base
        echo "进入 base 目录"
    fi

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
        rm -rf ./.cache > /dev/null
    fi
    return $ret
}

function git_submodule_sync()
{
    echo "git submodule update --init --recursive"
    git submodule update --init --recursive
    #添加一个将子仓库的分支切换到预设定的分支上的功能,或者给根据commitid找到对应分支
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

function utf8_encode_files_nobom()
{
    #将当前目录下的所有.c.h.cpp转换成utf8编码格式
    ~/.config/nvim/tools/script/python/file_to_utf8.py nobom $@
}

function utf8_encode_files()
{
    #将当前目录下的所有.c.h.cpp转换成utf8编码格式
    ~/.config/nvim/tools/script/python/file_to_utf8.py bom  $@
}

function gbk_gb2312_to_utf8_encode_files()
{
    ~/.config/nvim/tools/script/python/file_gbk_to_utf8.py $@
}

user_trash_name=.trash
user_trash_dir=~/$user_trash_name
# 上一次删除时的目录和文件列表
last_deleted_cwd=""
last_deleted_files=()
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
    # 重置记录
    last_deleted_cwd="$cur"
    last_deleted_files=()

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
                # 记录将要删除的文件名
                last_deleted_files+=("$(basename "$file")")
                mv "$file" "$user_trash_dir/"
            fi
            #echo "moved to trash: $file"
        else
            echo "rm(trash): cannot remove '$file': no such file or directory"
        fi
    done
}
#撤销刚刚删除的操作,恢复文件
function undo_trash() {
    # 检查有没有要恢复的
    if [ -z "$last_deleted_cwd" ] || [ "${#last_deleted_files[@]}" -eq 0 ]; then
        echo "没有可撤销的删除操作"
        return
    fi

    # 恢复文件
    for file in "${last_deleted_files[@]}"; do
        local src="$user_trash_dir/$file"
        local dest="$last_deleted_cwd/$file"

        if [ -e "$src" ]; then
            # 确保目标目录存在
            [ -d "$last_deleted_cwd" ] || mkdir -p "$last_deleted_cwd"
            mv "$src" "$dest"
            echo "恢复: $dest"
            #echo "恢复删除: mv "$src" "$dest""
        else
            echo "undo_trash: 在回收站找不到 '$file'"
        fi
    done

    # 清空记录
    last_deleted_cwd=""
    last_deleted_files=()
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

function mount_sshfs()
{
    param1=$1
    #安装工具
    #sudo apt update
    #sudo apt install sshfs sshpass
    #通过ssh_key公钥私钥的方式给到服务器,就可以不用每次都输入密码了
    mount_path=/home/user/linux/temp/$param1
    mkdir -p $mount_path
    sshfs $param1@192.168.111.21:/home/$param1 $mount_path
    echo "挂载完成 $?:sshfs $param1@192.168.111.21:/home/$param1 $mount_path"
    #mount | grep sshfs
    #取消挂在点
    #fusermount -u $mount_path
    #umount -u $mount_path
    #echo "取消挂载完成 $?:fusermount -u $mount_path"
}

# 使用 nvimdiff 比較兩個文件
alias vimdiff=nvimdiff
function nvimdiff()
{
    if [ $# -ne 2 ]; then
        echo "請提供兩個文件作為參數"
        return 1
    fi
    
    local LOCAL="$1"
    local REMOTE="$2"
    
    nvim -d "$LOCAL" "$REMOTE"
}

function bcompare()
{
    ~/.config/nvim/tools/script/windows_tools/use_win_bcompare.sh $@
}

function codecheck()
{
    # 比较简单的C语言代码扫描工具, 能扫描出一些常见的问题
    # sudo apt install cppcheck
    #level="--enable=warning"
    
    # 查找所有的 .c 和 .cpp 文件，排除所有以 build 开头的目录
    files=$(find . -type f \( -iname "*.c" -o -iname "*.cpp" \) ! -path "./build*" ! -path "./open_*" )
    cppcheck $files $level --xml --xml-version=2 --output-file=report.xml && cppcheck-htmlreport --file=report.xml --report-dir=html_report

}

###########################默认启动执行程序#############################
#google_translator_vim_on   #默认打开google翻译
#proxy_on    #开启了代理能google翻译了
path_simplify
go_proxy_on

#常用的临时自定义工作目录,修改路径,直接进入到这个目录里
tmp_cddd_path=/home/user/linux/work/kernel/kernel_t113
tmp_cdd_path=/home/user/linux/work/80/sip_backend
alias cdd='cd $tmp_cdd_path ; echo `pwd`'
alias cddd='cd $tmp_cddd_path ; echo `pwd`'

