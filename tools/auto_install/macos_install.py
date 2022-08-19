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

'''
mac快捷键:
Command（或 Cmd）⌘      Shift ⇧
Option（或 Alt）⌥       Control（或 Ctrl）⌃
Caps Lock ⇪
win == Command      Option == Alt

刷新网页:
    Command+r 刷新网页
截图:
    Shift+Control+Command+3键会在剪贴板里获取整个屏幕的截图
    Shift+Control+Command+4键则能使你通过拖动鼠标来截取部分屏幕，并复制图片到剪贴板:
    Control+Command+a键,微信截图
删除文件:
    Command+Backspace 删除文件
中文输入法输入半角符号:
    在右上角输入法右键选择对应选项,但是打括号,尖括号等不行
重命名:
    回车键
最小化:
    Command+M，最小化当前窗口
    Command+Option+M，最小化当前应用程序所有窗口
    Command+H，隐藏当前应用程序所有窗口的目的
    Command+Option+H，隐藏除当前应用程序之外所有程序窗口
    Command+Option+M+H，隐藏所有应用程序窗口的目的
放大被最小化的窗口:
    CMD+Tab 选中要还原/恢复的窗口
    仅松开Tab, 按住Opt,松开CMD。
全屏:
    Control+command+f
切换到桌面1,桌面2:
    Control+1 或 Control+2
开关程序坞:
    Option+Command+d
退出程序,大退:
    Command+Q
调出应用程序管理窗口:
    command+option+esc
'''
