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

#出现过LspInstallInfo 中nvim-lsp-installer-errors-github-api出错的情况
#通过安装github cli(gh)可以解决:
#VERSION=`curl  "https://api.github.com/repos/cli/cli/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/' | cut -c2-`
#curl -sSL https://github.com/cli/cli/releases/download/v${VERSION}/gh_${VERSION}_linux_amd64.tar.gz -o gh_${VERSION}_linux_amd64.tar.gz
#tar -xzvf gh_${VERSION}_linux_amd64.tar.gz
#sudo cp gh_${VERSION}_linux_amd64/bin/gh /usr/local/bin/
#sudo cp -r gh_${VERSION}_linux_amd64/share/man/man1/* /usr/share/man/man1/
#简单来说就是要安装github cli(gh),文件放在当前目录,复制到/usr/local/bin下即可
#实际发现是因为没有安装curl:)
sudo apt-get install curl
if [[ $? != 0 ]]; then
	exit -1
fi

#执行auto_install.py 1
./auto_install.py 1
if [[ $? != 0 ]]; then
	exit -1
fi
