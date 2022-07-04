#!/usr/bin/python3

import os
import sys
import urllib
import urllib.request

'''
替换apt源/etc/apt/sources.list:
apt-get update
apt-get install apt-transport-https ca-certificates安装https源
http://ftp.debian.org替换成https://repo.huaweicloud.com
http://security.debian.org替换成https://repo.huaweicloud.com

安装unzip, universal-ctags, global, tree,
make, bear, git, gcc, npm
g++,gcc-multilib g++-multilib(gcc支持32位编译)
安装fastgithub,nvim,添加环境变量到/etc/profile/xx.sh,启动http代理,
.~/.baserc中配置默认vim为neovim"alias vim='nvim',alias vi='nvim'"
启动fastgithub需要sudo启动一次

输入git账号密码, git不需要每次输入密码:git config --global credential.helper store
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
git clone --depth 1 https://github.com/lixiang130-user/nvim ~/.config/nvim

nvim中需要执行PackerSynv, 
'''

class script_install(object):
    __user_tools = os.path.expanduser('~')+'/.user_tools/'
    __fastgithub = __user_tools+'fastgithub_linux-x64/fastgithub'
    __script_dir = '../script/'
    __etc_profile_d_sh = __script_dir+'etc_profile_d_user_login_run.sh'
    __bashrc = os.path.expanduser('~')+'/.bashrc'
    def __init__(self):
        print('scripy_install __init__')
    def __del__(self):
        print('scripy_install __def__')
    def install(self):
        if not os.path.isdir(self.__user_tools):
            os.makedirs(self.__user_tools)
        #1.解压文件到user_tools,fastgithub_linux-x64/fastgithub需要root权限执行一次注册
        if os.path.isdir(self.__user_tools+'/nvim-linux64'):
            #os.removedirs(self.__user_tools+'/nvim-linux64')  #非空文件不能删除
            os.system('rm -rf '+self.__user_tools+'/nvim-linux64')
        if os.path.isdir(self.__user_tools+'/fastgithub_linux-x64'):
            os.system('rm -rf '+self.__user_tools+'/fastgithub_linux-x64')
        if(os.system('tar -xzvf ../compressed/nvim-linux64.tar.gz -C  '+self.__user_tools) != 0):exit(-1)
        if(os.system('tar -xzvf ../compressed/fastgithub_linux-x64.tar.gz -C  '+self.__user_tools) != 0):exit(-1)

        #2.复制脚本
        if(os.system('sudo cp '+self.__etc_profile_d_sh+' /etc/profile.d/') != 0):exit(-1)
        if(os.system('cp '+self.__script_dir+'/*.sh '+self.__user_tools) != 0):exit(-1)

        #3.~/.bashrc中配置默认vim为neovim"alias vim='nvim',alias vi='nvim'"
        f = open(self.__bashrc,'ab')
        f.write(b'\nalias vim=nvim\n')
        f.write(b'alias vi=nvim\n')
        f.write(b'alias ll=\'ls -a -l\'\n')
        f.close()

        print('fastgithub frist running')
        if(os.system('sudo '+self.__fastgithub+' &') != 0):exit(-1)
        if(os.system('sleep 8') != 0):exit(-1)
        if(os.system('sudo killall fastgithub') != 0):exit(-1)
        return True
    pass

class apt_sources_update(object):
    __src_sources = './sources.list'
    __dst_sources = '/etc/apt/sources.list'
    def __init__(self):
        print('apt_install __init__')
    def __del__(self):
        print('apt_install __def__')
    def update(self):
        if(os.system('sudo cp '+self.__src_sources+' '+self.__dst_sources) != 0):
            exit(-1)
        return True
    
    pass

class apt_install(object):
    def __init__(self):
        print('apt_install __init__')
    def __del__(self):
        print('apt_install __def__')
    def install(self):
        if(os.system('sudo apt-get update -y') != 0):exit(-1)
        if(os.system('sudo apt-get upgrade -y') != 0):exit(-1)
        if(os.system('sudo apt-get install -y unzip universal-ctags global') != 0):exit(-1)
        if(os.system('sudo apt-get install -y make bear git tree gcc npm dos2unix') != 0):exit(-1)
        if(os.system('sudo apt-get install -y g++ gcc-multilib g++-multilib') != 0):exit(-1)
        return True
    pass

class git_install(object):
    __packer = os.path.expanduser('~')+'/.local/share/nvim/site/pack/packer/start/packer.nvim'
    __nvim = os.path.expanduser('~')+'/.config/nvim'
    def __init__(self):
        print('git_install __init__')
    def __del__(self):
        print('git_install __def__')
    def install(self):
        if(os.system('git config --global credential.helper store') != 0):exit(-1)
        if(os.system('git config --global user.name lixiang130') != 0):exit(-1)
        if(os.system('git config --global user.email 1309776181@qq.com') != 0):exit(-1)
        if(os.system('git config --global pull.rebase false') != 0):exit(-1)
        if os.path.isdir(self.__nvim):
            os.system('rm -rf '+self.__nvim)
        if os.path.isdir(self.__packer):
            os.system('rm -rf '+self.__packer)

        if(os.system('git clone https://github.com/lixiang130-user/nvim '+self.__nvim) != 0):exit(-1)
        if(os.system('git clone --depth 1 https://github.com/wbthomason/packer.nvim '+self.__packer) != 0):exit(-1)
        return True
    pass

#run
if len(sys.argv) <= 1:
    print('plase set step 1 2 3')
elif sys.argv[1] == '1':
    print('run step 1')
    apt_source = apt_sources_update()
    apt_source.update()
    #安装常用工具
    apt = apt_install()
    apt.install()
    script = script_install()
    script.install()
    print('please logout and login for user, then run this script by param 2 again')
elif sys.argv[1] == '2':
    print('run step 2')
    git = git_install()
    git.install()
