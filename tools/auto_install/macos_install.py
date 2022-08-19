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
    .bash_profile 或 .zshrc中写入,下面的字符,
    在所有需要安装的都完毕后,在最后修改追加
    car macos_shellrc.sh >> ~/.zshrc

8.安装iterm2并设置为默认终端
    brew install iterm2
    打开iterm2 菜单中点击 make iterm2 default term
9.安装on-my-zsh 并 修改默认的shell, 这个是配合iterm2使用
    /bin/bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    chsh -s /bin/zsh    #修改为默认的终端
    #chsh -s /bin/bash	#修改会原来的终端
10.其他功能安装
'''
