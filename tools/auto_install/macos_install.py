#!python3
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
    Control+(<-, ->, 上, 下) Control+1 或 Control+2
显示桌面:
    F11
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
显示隐藏文件:
    Command+Shift+.
'''

'''
github mac passwd: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
1.安装xcode-select包含常用开发工具:
    xcode-select --install
2.安装brew:
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    /bin/bash -c "$(curl -fsSL https://gitee.com/ineo6/homebrew-install/raw/master/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
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


def usystem(cmd):
    ret = os.system(cmd)
    if ret != 0:
        exit(f'error:{ret} cmd:{cmd}')


def xcode_select_init():
    print('func:', sys._getframe().f_code.co_name, ' start')
    #usystem('xcode-select --install')

def homebrew_init():
    print('func:', sys._getframe().f_code.co_name, ' start')
    usystem('/bin/bash -c "$(curl -fsSL https://gitee.com/ineo6/homebrew-install/raw/master/install.sh)"')
    usystem('echo \'eval "$(/opt/homebrew/bin/brew shellenv)"\' >> ~/.zprofile')
    usystem('source ~/.zprofile && echo $PATH')
    usystem('cat ./macos_shellrc.sh >> ~/.zshrc')
    print('plase open new terminal and run all and proxy_on')

def macos_init():
    #安装主要功能
    usystem('brew install python3 npm neovim')
    #安装其他功能
    usystem('brew install tree trash carlocab/personal/unrar')
    #安装iterm2和on-my-zsh,可能需要翻墙,请提前安装好翻墙功能
    usystem('brew install iterm2')
    #安装bear C语言Make解析
    usystem('brew install bear')


def nvim_init():
    print('func:', sys._getframe().f_code.co_name, ' start')
    usystem('git config --global credential.helper store')
    usystem('git config --global user.name lixiang130')
    usystem('git config --global user.email 1309776181@qq.com')
    usystem('git config --global pull.rebase false')
    usystem('git config --global core.fileMode false')
    usystem('git config --global alias.st status')
    usystem('git clone https://github.com/lixiang130-user/nvim ~/.config/nvim')
    usystem('git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim')


def zsh_init():
    usystem('/bin/bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"')
    usystem('cat ./macos_shellrc.sh >> ~/.zshrc')
    usystem('chsh -s /bin/zsh')    #修改为默认的终端
    #usystem('chsh -s /bin/bash')	#修改会原来的终端
    #安装完成on-my-zsh后会修改~/.zshrc内容,再次追加会用户配置
    print('手动执行:打开iterm2 菜单中点击 make iterm2 default term')


class classname(object):
    def __init__(self):
        print('file:', __file__.split('/')[-1])
        print('class', self.__class__.__name__)
        print('func:', sys._getframe().f_code.co_name)
        print('line:', sys._getframe().f_lineno)
    pass


def func():
    print('func:', sys._getframe().f_code.co_name)

def python_init():
    usystem('pip3 install bs4 requests')


if __name__ == '__main__':
    print('python version:', sys.version)
    classname()
    func()
    print('main start')

    supports = ['macos_init', 'nvim_init', 'zsh_init']
    if len(sys.argv) <= 1:
        exit(f'plase set param in {supports}')
    elif sys.argv[1] == 'homebrew_init':
        eval(sys.argv[1])()
    elif sys.argv[1] in supports:
        eval(sys.argv[1])()
    elif sys.argv[1] == 'all':
        for support in supports:
            eval(support)()
    elif sys.argv[1] in "python_init":
        eval(sys.argv[1])()

    print('main end')
