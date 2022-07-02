#!/usr/bin/python3

import os
import urllib
import urllib.request

'''
手动部分:
下载fastgithub:https://github.com/dotnetcore/FastGithub/releases/download/2.1.4/fastgithub_linux-x64.zip
unzip fastgithub_linux-x64.zip
添加自动启动fastgit脚本

安装unzip, git, gcc,g++,gcc-multilib g++-multilib(gcc支持32位编译)
安装bear, universal-ctags, global
输入git账号密码, git不需要每次输入密码:git config --global credential.helper store

下载neovim:https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
tar -xzvf nvim-linux64.tar.gz
添加环境变量到/etc/profile/xx.sh
.~/.baserc中配置默认vim为neovim"alias vim='nvim',alias vi='nvim'"

unzip fastgithub_linux-x64.zip
添加自动启动fastgit脚本

git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
git clone --depth 1 https://github.com/lixiang130-user/nvim ~/.config/nvim  #不需要脚本操作

nvim中需要执行PackerSynv, 
'''

class apt_install(object):
    def __init__(self):
        print('apt_install __init__')
    def __del__(self):
        print('apt_install __def__')
    def install(self):
        if(os.system('sudo apt-get update -y') != 0):exit(-1)
        if(os.system('sudo apt-get upgrade -y') != 0):exit(-1)
        if(os.system('sudo apt-get install -y bear') != 0):exit(-1)
        if(os.system('sudo apt-get install -y universal-ctags global') != 0):exit(-1)
        if(os.system('sudo apt-get install -y git gcc g++ gcc-multilib g++-multilib') != 0):exit(-1)
        return True
    pass

class git_install(object):
    def __init__(self):
        print('git_install __init__')
        #if(os.system('git config --global credential.helper store') != 0):exit(-1)
        #if(os.system('git config --global user.name lixiang130') != 0):exit(-1)
        #if(os.system('git config --global user.email 1309776181@qq.com') != 0):exit(-1)
    def __del__(self):
        print('git_install __def__')
    def install(self):
        if(os.system('git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim') != 0):exit(-1)
        return True
    pass

class nvim_get(object):
    __url = 'https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz'
    __dir = '/home/user/.user_tools/'
    __fname = 'nvim-linux64.tar.gz'
    def __init__(self):
        print('nvim_get __init__')
    def __del__(self):
        print('nvim_get __def__')
    def get(self):
        if not os.path.isdir(dir):
            os.makedirs(dir)
        response = urllib.request.urlopen(url)
        f = open(dir+fname, 'wb')
        while(len(data := response.read())):
            print('.')
            f.write(data)
    pass

#apt = apt_install()
#apt.install()
#apt = git_install()
#apt.install()
nvim = nvim_get()
#nvim.get()
print(nvim.__url)
print(nvim._nvim_get__url)
