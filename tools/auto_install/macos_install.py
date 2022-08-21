#!/usr/bin/python3
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
撤销:
    Command+z
重做:
    Command+Shift+z(Command+Z)
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
切换到右侧左侧,桌面1,桌面2:
    Control+(->, ->) Control+1 或 Control+2
开关程序坞:
    Option+Command+d
退出程序,大退:
    Command+Q
调出应用程序管理窗口:
    command+option+esc
文件管理器:
去上层文件:
    Command+⬆️
后退:
    Command+[
前进:
    Command+]
多窗口页面,现实所有窗口:
    Command+Shift+\
同应用切换窗口:
    Command+~(tab上面到案件)
同窗口切换tab:
    Control+tab
    部分可以Command+左右,或Command+option+左右
浏览器自动填充密码
    Command+Shift+a
打开文件管理器:
    Command+⬆️

'''

'''
github mac passwd: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
1.安装xcode-select包含常用开发工具:
    xcode-select --install
2.安装brew:
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    /bin/bash -c "$(curl -fsSL https://gitee.com/ineo6/homebrew-install/raw/master/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/user/.zprofile
    卸载:
    /bin/bash -c "$(curl -fsSL https://gitee.com/ineo6/homebrew-install/raw/master/uninstall.sh)"

3.安装python3, npm, nvim, iterm2
    brew install python3 npm neovim iterm2
    打开iterm2 菜单中点击 make iterm2 default term
4.安装on-my-zsh 并 修改默认的shell, 这个是配合iterm2使用
    /bin/bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    chsh -s /bin/zsh    #修改为默认的终端
    #chsh -s /bin/bash	#修改会原来的终端

5.翻墙软件clashx
    .bash_profile 或 .zshrc中写入,下面的字符,
    在所有需要安装的都完毕后,在最后修改追加
    car macos_shellrc.sh >> ~/.zshrc


6.配置git用户
    if(os.system('git config --global credential.helper store') != 0):exit(-1)
    if(os.system('git config --global user.name lixiang130') != 0):exit(-1)
    if(os.system('git config --global user.email 1309776181@qq.com') != 0):exit(-1)
    if(os.system('git config --global pull.rebase false') != 0):exit(-1)
    if(os.system('git config --global core.fileMode false') != 0):exit(-1)

7.下载nvim配置,下载安装packer:
    git clone https://github.com/lixiang130-user/nvim ~/.config/nvim
    git clone --depth 1 https://github.com/wbthomason/packer.nvim \
            ~/.local/share/nvim/site/pack/packer/start/packer.nvim

8.其他功能安装
    brew install tree trash
    trash 时替代rm,将删除到文件移动到废纸篓
'''


import sys, os

if __name__ == '__main__':
    if len(sys.argv) <= 1:
        exit('plase set param ...')
    if sys.argv[1] == 'nvim_clone':
        if(os.system('git config --global credential.helper store') != 0):exit(-1)
        if(os.system('git config --global user.name lixiang130') != 0):exit(-1)
        if(os.system('git config --global user.email 1309776181@qq.com') != 0):exit(-1)
        if(os.system('git config --global pull.rebase false') != 0):exit(-1)
        if(os.system('git config --global core.fileMode false') != 0):exit(-1)
        if(os.system('git clone https://github.com/lixiang130-user/nvim ~/.config/nvim') != 0):exit(-1)
        if(os.system('git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim') != 0):exit(-1)
