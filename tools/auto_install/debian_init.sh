#!/bin/bash

#debian中最最开始的环境配置
sudo apt-get update -y
if [[ $? != 0 ]]; then
	exit -1
fi
sudo apt-get install apt-transport-https ca-certificates -y
if [[ $? != 0 ]]; then
	exit -1
fi
sudo cp ./sources.list /etc/apt/sources.list
if [[ $? != 0 ]]; then
	exit -1
fi
sudo apt-get update -y
if [[ $? != 0 ]]; then
	exit -1
fi
sudo apt-get upgrade -y
if [[ $? != 0 ]]; then
	exit -1
fi
#安装debian自动补全工具
sudo apt-get install bash-completion -y
if [[ $? != 0 ]]; then
	exit -1
fi
sudo apt-get install python3 -y
if [[ $? != 0 ]]; then
	exit -1
fi
#安装debian中killall命令
sudo apt-get install psmisc
if [[ $? != 0 ]]; then
	exit -1
fi

#执行auto_install.py 1
./auto_install.py 1
if [[ $? != 0 ]]; then
	exit -1
fi
