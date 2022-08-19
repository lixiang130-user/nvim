#!/usr/bin/python3

'''
github mac passwd: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
1.安装xcode-select包含常用开发工具:
    xcode-select --install
2.安装brew:
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
3.安装python3, npm:
    brew install python3 npm
4.brew install neovim
5.下载安装packer:
    git clone --depth 1 https://github.com/wbthomason/packer.nvim \
            ~/.local/share/nvim/site/pack/packer/start/packer.nvim

6.或许要更换主题,linux下用的nvim主题macos下可能不好看
7.翻墙软件clashx
    .bash_profile 或 .zshrc中写入:

8.安装iterm2并设置为默认终端
    brew install iterm2
    打开iterm2 菜单中点击 make iterm2 default term

9.其他功能安装
'''


'''
.bash_profile 或 .zshrc中写入:
function proxy_on()
{
    export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
    export http_proxy="http://127.0.0.1:7890"
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

alias vi='nvim'
alias vim='nvim'
alias ll='ls -al'
export PATH=$PATH:/opt/homebrew/bin

'''
