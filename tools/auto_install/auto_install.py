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
jq 格式化json的工具
安装fastgithub,nvim,添加环境变量到/etc/profile/xx.sh,启动http代理,
.~/.baserc中配置默认vim为neovim"alias vim='nvim',alias vi='nvim'"
启动fastgithub需要sudo启动一次

输入git账号密码, git不需要每次输入密码:git config --global credential.helper store
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
git clone --depth 1 https://github.com/lixiang130-user/nvim ~/.config/nvim

nvim中需要执行PackerSynv, 
'''


class script_install(object):
    __user_root = os.path.expanduser('~')
    __pwd_path = os.getcwd()
    __pwd_root = __pwd_path+'/../../'
    __bashrc = __user_root+'/.bashrc'
    __user_tools = __user_root+'/.config/'
    #__fastgithub = __user_tools+'fastgithub_linux-x64/fastgithub'
    __user_tools_sh = __user_tools+'nvim/tools/script/user_tools.sh'

    def __init__(self):
        print('scripy_install __init__')

    def __del__(self):
        print('scripy_install __def__')

    def install(self):
        if not os.path.isdir(self.__user_tools):
            os.makedirs(self.__user_tools)
        #1.解压文件到.config
        if os.path.isdir(self.__user_tools+'/nvim-linux64'):
            #os.removedirs(self.__user_tools+'/nvim-linux64')  #非空文件不能删除
            os.system('rm -rf '+self.__user_tools+'/nvim-linux64')
        if(os.system('tar -xzvf ../compressed/nvim-linux64.tar.gz -C  '+self.__user_tools) != 0):exit(-1)

        #3.~/.bashrc中配置默认vim为neovim"alias vim='nvim',alias vi='nvim'"
        #f = open(self.__bashrc,'ab')
        #f.write(b'\nalias vim=nvim\n')
        #f.write(b'alias vi=nvim\n')
        #f.write(b'alias ll=\'ls -a -l\'\n')
        #f.close()
        if(os.system('echo "source '+self.__user_tools_sh+'" >> '+self.__bashrc) != 0):exit(-1)

        '''
        #安装fastgithub
        if os.path.isdir(self.__user_tools+'/fastgithub_linux-x64'):
            os.system('rm -rf '+self.__user_tools+'/fastgithub_linux-x64')
        if(os.system('tar -xzvf ../compressed/fastgithub_linux-x64.tar.gz -C  '+self.__user_tools) != 0):exit(-1)
        #2.复制脚本
        # if(os.system('sudo cp '+self.__user_tools_sh+' /etc/profile.d/') != 0):exit(-1)
        if(os.system('cp '+self.__script_dir+'/fastgithub_start.sh '+self.__user_tools) != 0):exit(-1)
        #fastgithub_linux-x64/fastgithub需要root权限执行一次注册
        print('fastgithub frist running')
        if(os.system('sudo '+self.__fastgithub+' &') != 0):exit(-1)
        if(os.system('sleep 8') != 0):exit(-1)
        if(os.system('sudo killall fastgithub') != 0):exit(-1)
        '''
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
        #添加32位支持
        if(os.system('sudo dpkg --add-architecture i386') != 0):exit(-1)
        print('安装环境 行号:', sys._getframe().f_lineno, '返回值:')
        if(os.system('sudo apt-get update -y') != 0):exit(-1)
        print('安装环境 行号:', sys._getframe().f_lineno, '返回值:')
        if(os.system('sudo apt-get upgrade -y') != 0):exit(-1)
        print('安装环境 行号:', sys._getframe().f_lineno, '返回值:')
        if(os.system('sudo apt-get install -y universal-ctags') != 0):exit(-1)
        print('安装环境 行号:', sys._getframe().f_lineno, '返回值:')
        if(os.system('sudo apt-get install -y unzip make bear git tree') != 0):exit(-1)
        print('安装环境 行号:', sys._getframe().f_lineno, '返回值:')
        if(os.system('sudo apt-get install -y npm dos2unix ripgrep gcc') != 0):exit(-1)
        print('安装环境 行号:', sys._getframe().f_lineno, '返回值:')
        if(os.system('sudo apt-get install -y g++ gcc-multilib g++-multilib gitk') != 0):exit(-1)
        print('安装环境 行号:', sys._getframe().f_lineno, '返回值:')
        if(os.system('sudo apt-get install -y python3-venv jq') != 0):exit(-1)
        print('安装环境 行号:', sys._getframe().f_lineno, '返回值:')
        if(os.system('sudo apt-get autoremove -y man*') != 0):exit(-1)  #重新安装man,默认的不能用
        print('安装环境 行号:', sys._getframe().f_lineno, '返回值:')
        if(os.system('sudo apt-get install -y man-db manpages-de manpages-de-dev manpages-dev glibc-doc manpages-posix-dev manpages-posix') != 0):exit(-1)
        print('安装环境 行号:', sys._getframe().f_lineno, '返回值:')
        if(os.system('sudo apt-get install -y expect fd-find net-tools') != 0):exit(-1)
        print('安装环境 行号:', sys._getframe().f_lineno, '返回值:')
        #安装网卡相关工具,可以重启网络服务 https://wenku.csdn.net/answer/090260ad71424adb956f41585fd24c1b
        #sudo service networking restart    重启网络服务
        if(os.system('sudo apt-get install -y ifupdown') != 0):exit(-1)
        print('安装环境 行号:', sys._getframe().f_lineno, '返回值:')
        #配置虚拟网卡需要   https://www.cnblogs.com/eleclsc/p/11677100.html
        if(os.system('sudo apt-get install -y uml-utilities bridge-utils') != 0):exit(-1)
        print('安装环境 行号:', sys._getframe().f_lineno, '返回值:')
        #执行工具替换riggrep,可以修复telescope不能忽略gitignore的问题
        if(os.system('cd ../script/python && ./rg.py user_replace && cd -') != 0):exit(-1)
        print('安装环境 行号:', sys._getframe().f_lineno, '返回值:')
        #安装go语言
        if(os.system('sudo snap install go --classic') != 0):exit(-1)
        print('安装环境 行号:', sys._getframe().f_lineno, '返回值:')
        return True
    pass

class cfg_config(object):
    __script_dir = '../script/'
    __local_conf_dir = __script_dir+'local.conf'
    def install(self):
        print('cfg_config install start')

        # wslg 中文乱码问题修复
        if(os.system('sudo locale-gen') != 0):exit(-1)
        if(os.system('locale') != 0):exit(-1)
        if(os.system('sudo apt-get install -y fontconfig') != 0):exit(-1)
        if(os.system('sudo cp '+self.__local_conf_dir+' /etc/fonts/local.conf') != 0):exit(-1)

        # 无法查看gbk编码中文问题 https://codeantenna.com/a/BY90IMFcTY
        # 实际与utf8互斥,不能同时用,中断很多中文也不正常了,不建议用
        #zh_CN_str = '\nzh_CN GB2312\nzh_CN.GB18030 GB18030\nzh_CN.GBK GBK\nzh_CN.UTF-8 UTF-8\n'
        #if(os.system('sudo apt-get install -y language-pack-zh-hans') != 0):exit(-1)
        #if(os.system('sudo echo ' + zh_CN_str + ' >> /etc/locale.gen') != 0):exit(-1)
        #if(os.system('sudo locale-gen') != 0):exit(-1)
        #if(os.system('sudo echo "LANG=zh_CN.GBK" > /etc/locale.gen') != 0):exit(-1)

        #一些nvim依赖 npm安装
        ret = os.system('sudo npm install -g neovim')
        print('安装环境 行号:', sys._getframe().f_lineno, '返回值:', ret)

        print('cfg_config install end')
        pass
    pass

class bcompare_install(object):
    __pwd_path = os.getcwd()
    __pwd_root = __pwd_path+'/../../'
    __becompare = __pwd_root+'/tools/compressed/bcompare-4.4.6.27483_amd64.deb'

    def __init__(self):
        print('bcompare_install __init__')

    def __del__(self):
        print('bcompare_install __def__')

    def install(self):
        #bcompare安装和其依赖和破解
        key = '''
--- BEGIN LICENSE KEY ---
GXN1eh9FbDiX1ACdd7XKMV7hL7x0ClBJLUJ-zFfKofjaj2yxE53xauIfkqZ8FoLpcZ0Ux6McTyNmODDSvSIHLYhg1QkTxjCeSCk6ARz0ABJcnUmd3dZYJNWFyJun14rmGByRnVPL49QH+Rs0kjRGKCB-cb8IT4Gf0Ue9WMQ1A6t31MO9jmjoYUeoUmbeAQSofvuK8GN1rLRv7WXfUJ0uyvYlGLqzq1ZoJAJDyo0Kdr4ThF-IXcv2cxVyWVW1SaMq8GFosDEGThnY7C-SgNXW30jqAOgiRjKKRX9RuNeDMFqgP2cuf0NMvyMrMScnM1ZyiAaJJtzbxqN5hZOMClUTE+++
--- END LICENSE KEY -----'''
        if(os.system('sudo apt install -y '+self.__becompare) != 0): exit(-1)
        if(os.system('sudo apt --fix-broken install -y') != 0):exit(-2)
        os.system('rm -rf ~/.config/bcompare')
        os.system('sudo rm -rf /etc/apt/sources.list.d/scootersoftware.list')   #删除bc的地址,否则apt update失败
        os.system('sudo sed -i "s/keexjEP3t4Mue23hrnuPtY4TdcsqNiJL-5174TsUdLmJSIXKfG2NGPwBL6vnRPddT7tH29qpkneX63DO9ECSPE9rzY1zhThHERg8lHM9IBFT+rVuiY823aQJuqzxCKIE1bcDqM4wgW01FH6oCBP1G4ub01xmb4BGSUG6ZrjxWHJyNLyIlGvOhoY2HAYzEtzYGwxFZn2JZ66o4RONkXjX0DF9EzsdUef3UAS+JQ+fCYReLawdjEe6tXCv88GKaaPKWxCeaUL9PejICQgRQOLGOZtZQkLgAelrOtehxz5ANOOqCaJgy2mJLQVLM5SJ9Dli909c5ybvEhVmIC0dc9dWH+/N9KmiLVlKMU7RJqnE+WXEEPI1SgglmfmLc1yVH7dqBb9ehOoKG9UE+HAE1YvH1XX2XVGeEqYUY-Tsk7YBTz0WpSpoYyPgx6Iki5KLtQ5G-aKP9eysnkuOAkrvHU8bLbGtZteGwJarev03PhfCioJL4OSqsmQGEvDbHFEbNl1qJtdwEriR+VNZts9vNNLk7UGfeNwIiqpxjk4Mn09nmSd8FhM4ifvcaIbNCRoMPGl6KU12iseSe+w+1kFsLhX+OhQM8WXcWV10cGqBzQE9OqOLUcg9n0krrR3KrohstS9smTwEx9olyLYppvC0p5i7dAx2deWvM1ZxKNs0BvcXGukR+/g" /usr/lib/beyondcompare/BCompare')
        #if(os.system('sudo apt autoremove -y --purge bcompare') != 0):exit(-1)
        os.system('echo "' + key + '" | uclip.exe')
        print('echo "' + key + '" | uclip.exe')
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
        if(os.system('git config --global alias.st status') != 0):exit(-1)
        if(os.system('git config --global http.postbuffer 1048576000') != 0):exit(-1)   #更新git的http post缓冲区值
        if(os.system('git config --global https.postBuffer 1048576000') != 0):exit(-1)
        #在终端中运行以下命令来配置 Git 的差异工具为 nvim：
        os.system('git config --global diff.tool nvimdiff')
        #需要设置 nvimdiff 的命令。这需要使用 difftool 配置来指定 Neovim 的命令行启动参数：
        #这里，"$LOCAL" 和 "$REMOTE" 是 Git 用来表示需要比较的两个文件的占位符。
        os.system('''git config --global difftool.nvimdiff.cmd 'nvim -d "$LOCAL" "$REMOTE"' ''')
        #if(os.system('git config --global http.version HTTP/1.1') != 0):exit(-1)    #git使用http1.1,使用2遇到过问题
        #if(os.system('git config --global http.version HTTP/2') != 0):exit(-1)

        #更新nvim仓库
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

    def install_pymisc(self):
        #if(os.system('pip install baostock') != 0):exit(-1)
        if(os.system('sudo npm install -g express') != 0):exit(-1)  #使用npmexpress框架作为http服务运行js 辅助工具:express-generator
        if(os.system('pip install pymysql requests lxml bs4 parsel aiohttp') != 0):exit(-1)
        if(os.system('pip install pyquery') != 0):exit(-1)  #xml解析,在用别人的爬代理ip时用到
        if(os.system('pip install pyexecjs') != 0):exit(-1)  #python模拟执行javaScript库
        #if(os.system('pip install mitmproxy') != 0):exit(-1)    #mitmproxy是一个http(s)抓包工具,抓手机app的包, 在wsl中需要按照教程配置: https://www.likecs.com/show-273420.html
        #if(os.system('sudo npm install -g appium') != 0):exit(-1)  #控制手机自动化操作工具,需要安装android stdio,苹果也比较麻烦
        #if(os.system('pip install Appium-Python-Client') != 0):exit(-1)  #appium 客户端

    def install_browser(self):
        #if(os.system('sudo apt-get install -y fonts-liberation wget dbus-x11') != 0):exit(-1)
        if(os.system('sudo apt-get install -y chromium') != 0):exit(-1)
        if(os.system('which chromium && chromium --version') != 0):exit(-1)
        if(os.system('unzip ../compressed/chromedriver_linux64.zip') != 0):exit(-1)
        if(os.system('sudo mv chromedriver /usr/local/bin/ && chromedriver --version') != 0):exit(-1)
        if(os.system('sudo apt-get install fonts-wqy-microhei') != 0):exit(-1)
        if(os.system('pip install selenium playwright') != 0):exit(-1)
        if(os.system('playwright install') != 0):exit(-1)
        if(os.system('playwright install-deps') != 0):exit(-1)
        #若浏览器闪退或打开时自动输入按键字母,则从 https://aka.ms/wslstorepage 安装最新开发版wsl,即可修复

    def install_pyverify(self):
        if(os.system('sudo apt-get install -y tesseract-ocr libtesseract-dev') != 0):exit(-1)
        if(os.system('sudo apt-get install -y libleptonica-dev') != 0):exit(-1)
        if(os.system('pip install tesserocr pillow numpy retrying') != 0):exit(-1)
        #if(os.system('pip install opencv-python') != 0):exit(-1)
        #代理安装proxifier软件设置127.0.0.1:7890

    def install_scrapy(self):
        if(os.system('sudo apt-get install -y build-essential python3-dev \
            libssl-dev libxml2-dev openssl') != 0):exit(-1)
        if(os.system('pip install Scrapy pillow') != 0):exit(-1)
        if(os.system('pip install scrapy-playwright') != 0):exit(-1)

    def install_mysql(self):
        #mysql相关
        if(os.system('sudo apt-get install -y mariadb-server') != 0):exit(-1)
        if(os.system('sudo service mariadb start') != 0):exit(-1)
        if(os.system('sudo mysql') != 0):exit(-1)
        '''
        #配置mysql
        ALTER USER root@localhost IDENTIFIED VIA mysql_native_password USING PASSWORD("Mysql1234.");
        #if(os.system('sudo apt-get install -y mysql-server') != 0):exit(-1)
        #if(os.system('sudo /etc/init.d/mysql start') != 0):exit(-1)
        #if(os.system('sudo mysql') != 0):exit(-1)
        ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password by 'Mysql1234.';
        '''
        if(os.system('sudo mysql_secure_installation') != 0):exit(-1)
        #然后全部选择否n
        '''
        #然后修改/etc/mysql/mariadb.conf.d/50-server.cnf:18 datadir = /home/user/linux/mysql
        #复制/var/lib/mysql文件 到/home/user/linux/mysql 处
        os.system('mkdir /home/user/linux')
        if(os.system('sudo cp ../script/mysql_50-server.cnf\
                /etc/mysql/mariadb.conf.d/50-server.cnf') != 0):exit(-1)
        if(os.system('sudo cp -r /var/lib/mysql /home/user/linux/mysql') != 0):exit(-1)
        if(os.system('sudo chown mysql:mysql -R /home/user/linux/mysql') != 0):exit(-1)
        os.system('sudo service mariadb stop')
        os.system('sudo service mariadb start')
        #若重启mysql服务失败,则需要重启系统
        '''

    def install_pyside(self):
        if(os.system('pip install pyside6') != 0):exit(-1)

    def install_pyinstaller(self):
        if(os.system('pip install pyinstaller') != 0):exit(-1)
        '''
        https://www.pc6.com/softview/SoftView_104246.html
        windows可执行的exe需要安装微软常用运行库中的:
        Microsoft Visual C++ 2005-2019 Redistributable – 14.28.29301
        再打包才能用, 而且windows下也要安装python3,
        pyside6(界面用的windows下的库,
        pyinstaller(打包工具用的pyinstall.exe
        这样打包后的exe, 就可以在没有环境的电脑上运行
        '''

    def install_kivy(self):
        #不好用,教程少,暂时不要了
        #稳定版
        if(os.system('sudo apt-get install -y python3-kivy python-kivy-examples') != 0):exit(-1)
        #依赖
        if(os.system('sudo apt-get install -y libmtdev-dev libmtdev1 xclip') != 0):exit(-1)
        if(os.system('pip install cython kivy pygame') != 0):exit(-1)

    def install(self, type=''):
        #print(sys._getframe().f_lineno)
        if type =='all' or type == 'py':
            #股票,mysql等库
            if(os.system('sudo apt-get install -y python3-pip') != 0):exit(-1)
        if type =='all' or type == 'pymisc':
            self.install_pymisc()
        if type =='all' or type == 'pyverify':
            self.install_pyverify()
        if type =='all' or type == 'browser':
            self.install_browser()
        if type =='all' or type == 'scrapy':
            self.install_scrapy()
        if type =='all' or type == 'mysql':
            self.install_mysql()
        if type =='all' or type == 'pyside':
            self.install_pyside()
        if type =='all' or type == 'pyinstaller':
            self.install_pyinstaller()
    pass


#run
if len(sys.argv) <= 1:
    print('plase set step 1 2 work ...')
elif sys.argv[1] == '1':
    print('run step 1')
    #apt_source = apt_sources_update()
    #apt_source.update()
    #安装常用工具
    apt = apt_install()
    apt.install()
    cfg = cfg_config()
    cfg.install()
    script = script_install()
    script.install()
    print('please logout and login for user, then run this script by param 2 again')
elif sys.argv[1] == '2':
    print('run step 2')
    git = git_install()
    git.install()
elif sys.argv[1] == 'work': #工作需要的环境
    ret = os.system('sudo apt-get install -y cmake zip kconfig-frontends')
    print('安装工作环境 行号:', sys._getframe().f_lineno, '返回值:', ret)
    #ret = os.system('sudo apt-get install -y flex bison bc libncurses5 libpython2.7 python2')
    ret = os.system('sudo apt-get install -y flex bison libncurses5 libpython2.7 python2')
    print('安装工作环境 行号:', sys._getframe().f_lineno, '返回值:', ret)
    ret = os.system('sudo apt-get install -y device-tree-compiler')
    print('安装工作环境 行号:', sys._getframe().f_lineno, '返回值:', ret)
    ret = os.system('sudo rm /usr/bin/python ; sudo ln -s /usr/bin/python2 /usr/bin/python')  #创建python的连接符
    print('安装工作环境 行号:', sys._getframe().f_lineno, '返回值:', ret)
    #lvgl在linux上运行所需的sdl环境,展示界面用的:https://github.com/lvgl/lv_port_pc_vscode
    ret = os.system('sudo apt-get install -y build-essential libsdl2-dev')
    print('安装工作环境 行号:', sys._getframe().f_lineno, '返回值:', ret)
    #esp32编译环境安装 https://docs.espressif.com/projects/esp-idf/zh_CN/latest/esp32/get-started/linux-macos-setup.html
    ret = os.system('sudo apt-get install -y git wget flex bison gperf')
    print('安装工作环境 行号:', sys._getframe().f_lineno, '返回值:', ret)
    ret = os.system('sudo apt-get install -y python3 python3-pip python3-venv')
    print('安装工作环境 行号:', sys._getframe().f_lineno, '返回值:', ret)
    ret = os.system('sudo apt-get install -y cmake ninja-build ccache libffi-dev libssl-dev dfu-util libusb-1.0-0')
    print('安装工作环境 行号:', sys._getframe().f_lineno, '返回值:', ret)
    ret = os.system('sudo apt install -y inetutils-telnet libpcre3-dev')
    print('安装工作环境 行号:', sys._getframe().f_lineno, '返回值:', ret)
    ret = os.system('sudo apt install -y dosfstools')
    print('安装工作环境 行号:', sys._getframe().f_lineno, '返回值:', ret)
    ret = os.system('sudo ln -sf /bin/bash /bin/sh')
    print('安装工作环境 行号:', sys._getframe().f_lineno, '返回值:', ret)
    ret = os.system('sudo apt-get install autoconf automake libtool texinfo')
    print('安装工作环境 行号:', sys._getframe().f_lineno, '返回值:', ret)

    #安装libiconv1.13 编译ssc337需要
    if(os.system('''
                 wget https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.13.tar.gz &&
                 tar -xzvf libiconv-1.13.tar.gz &&
                 cd libiconv-1.13 &&
                 ./configure --prefix=/usr/local &&
                 make &&
                 sudo make install &&
                 sudo ln -s /usr/local/lib/libiconv.so.2 /usr/lib/libiconv.so.2 &&
                 cd .. && rm -rf libiconv-1.13 libiconv-1.13.tar.gz
                 ''') != 0):exit(-1)
    #安装libmpfr.so.4.1.4 依赖libgmp 编译ssc337需要
    if(os.system('''
                 wget https://mirrors.aliyun.com/gnu/mpfr/mpfr-4.1.1.tar.gz &&
                 tar -xzvf mpfr-4.1.1.tar.gz &&
                 cd mpfr-4.1.1 &&
                 sudo apt-get install libgmp-dev  &&
                 ./configure --prefix=/usr/local --with-gmp=/usr && 
                 make && 
                 sudo make install && 
                 sudo ln -sf /usr/local/lib/libmpfr.so /usr/lib/libmpfr.so.4 &&
                 cd .. && rm -rf mpfr-4.1.1 mpfr-4.1.1.tar.gz
                 ''') != 0):exit(-1)
    #ssc337系统编译工具需要这个
    if(os.system('sudo apt install zlib1g:i386') != 0):exit(-1)
    #更新squashfs-tools到4.6.1 已有版本会崩溃
    if(os.system('''
                 wget https://github.com/plougher/squashfs-tools/archive/refs/tags/4.6.1.tar.gz &&
                 tar -xzvf 4.6.1.tar.gz &&
                 cd squashfs-tools-4.6.1/squashfs-tools &&
                 sudo apt install build-essential zlib1g-dev liblzma-dev liblzo2-dev &&
                 make XZ_SUPPORT=1 LZO_SUPPORT=1 -j$(nproc) &&
                 sudo cp mksquashfs /usr/local/bin/mksquashfs_xz_new &&
                 cd ../.. && rm -rf 4.6.1.tar.gz squashfs-tools-4.6.1
                 ''') != 0):exit(-1)

elif sys.argv[1] == 'bc': #工作需要的环境
    bc = bcompare_install()
    bc.install()
elif sys.argv[1] == 'spider':
    print('run step ', sys.argv[1])
    python_rely().install(sys.argv[1])
elif sys.argv[1] == 'docker':
    print('run step ', sys.argv[1])
    #安装
    ret = os.system('proxy_on &&  curl -fsSL https://test.docker.com -o test-docker.sh && sudo sh test-docker.sh')
    print('安装工作环境 行号:', sys._getframe().f_lineno, '返回值:', ret)
    #禁止docker开机自启
    ret = os.system('sudo systemctl disable docker && sudo systemctl is-enabled docker')
    print('安装工作环境 行号:', sys._getframe().f_lineno, '返回值:', ret)
    #将普通用户添加到docker组中,可以不用sudo就可以执行docker
    ret = os.system("grep '^docker' /etc/group && sudo usermod -aG docker user && newgrp docker")
    print('安装工作环境 行号:', sys._getframe().f_lineno, '返回值:', ret)
