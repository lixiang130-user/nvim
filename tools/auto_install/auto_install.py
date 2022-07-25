#!/usr/bin/python3

import os
import sys

'''
替换apt源/etc/apt/sources.list:
apt-get update
apt-get install apt-transport-https ca-certificates安装https源
http://ftp.debian.org替换成https://repo.huaweicloud.com
http://security.debian.org替换成https://repo.huaweicloud.com

安装unzip, tree, make, bear, git, gcc, npm, ripgrep, Vista
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
    __src_sources = '../script/sources.list'
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
        if(os.system('sudo apt-get install -y universal-ctags') != 0):exit(-1)
        if(os.system('sudo apt-get install -y unzip make bear git tree') != 0):exit(-1)
        if(os.system('sudo apt-get install -y npm dos2unix ripgrep gcc') != 0):exit(-1)
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
        if(os.system('git config --global core.fileMode false') != 0):exit(-1)
        if os.path.isdir(self.__nvim):
            os.system('rm -rf '+self.__nvim)
        if os.path.isdir(self.__packer):
            os.system('rm -rf '+self.__packer)

        if(os.system('git clone https://github.com/lixiang130-user/nvim '+self.__nvim) != 0):exit(-1)
        if(os.system('git clone --depth 1 https://github.com/wbthomason/packer.nvim '+self.__packer) != 0):exit(-1)
        return True
    pass

class python_rely(object):
    def __init__(self):
        print(__name__, ' __init__')
    def __del__(self):
        print(__name__, ' __def__')
    def install(self, type=1):
        #print(sys._getframe().f_lineno)
        if type == 1:
            #股票,mysql等库
            if(os.system('sudo apt-get install -y python3-pip') != 0):exit(-1)
            #if(os.system('pip install baostock') != 0):exit(-1)
            if(os.system('pip install pymysql') != 0):exit(-1)

            #mysql相关
            if(os.system('sudo apt-get install -y mariadb-server') != 0):exit(-1)
        if type == 2:
            if(os.system('sudo service mariadb start') != 0):exit(-1)
            #配置mysql
            if(os.system('sudo mysql') != 0):exit(-1)
            #ALTER USER root@localhost IDENTIFIED VIA mysql_native_password USING PASSWORD("Mysql1234.");

            #if(os.system('sudo apt-get install -y mysql-server') != 0):exit(-1)
            #if(os.system('sudo /etc/init.d/mysql start') != 0):exit(-1)
            #if(os.system('sudo mysql') != 0):exit(-1)
            #ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password by 'Mysql1234.';

            if(os.system('sudo mysql_secure_installation') != 0):exit(-1)
            #然后全部选择否n

        if type == 3:
            #然后修改/etc/mysql/mariadb.conf.d/50-server.cnf:18 datadir = /home/user/linux/mysql
            #复制/var/lib/mysql文件 到/home/user/linux/mysql 处
            os.system('mkdir /home/user/linux')
            if(os.system('sudo cp ../script/mysql_50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf') != 0):exit(-1)
            if(os.system('sudo cp -r /var/lib/mysql /home/user/linux/mysql') != 0):exit(-1)
            if(os.system('sudo chown mysql:mysql -R /home/user/linux/mysql') != 0):exit(-1)
            os.system('sudo service mariadb stop')
            os.system('sudo service mariadb start')
            #若重启mysql服务失败,则需要重启系统
        return
    pass

class chrome_driver(object):
    def install(self):
        if(os.system('curl -o chrome.deb  https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb') != 0):exit(-1)
        if(os.system('sudo apt-get install -y fonts-liberation wget dbus-x11') != 0):exit(-1)
        if(os.system('sudo dpkg -i chrome.deb') != 0):exit(-1)
        if(os.system('which google-chrome && google-chrome --version') != 0):exit(-1)
        if(os.system('curl -o driver.zip https://chromedriver.storage.googleapis.com/103.0.5060.134/chromedriver_linux64.zip') != 0):exit(-1)
        if(os.system('unzip driver.zip && rm driver.zip') != 0):exit(-1)
        if(os.system('sudo mv chromedriver /usr/bin/ && chromedriver -v') != 0):exit(-1)
        if(os.system('pip install selenium') != 0):exit(-1)
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
elif sys.argv[1] == 'py1':
    print('run step py1')
    python_rely().install(1)
elif sys.argv[1] == 'py2':
    print('run step py2')
    python_rely().install(2)
elif sys.argv[1] == 'py3':
    print('run step py3')
    python_rely().install(3)
elif sys.argv[1] == 'chrome':
    chrome_driver().install();
