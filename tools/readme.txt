1.fastgithub工具下载:https://fastgithub.cn/download
2.neovim下载:https://github.com/neovim/neovim/releases/nightly
3.工具放到~/.user_tools下
4.配置neovim信息放到~/.config/nvim/下
5.clone 插件packer,保存路径固定在~/.config下,想要修改路径比较困难
    git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

6.~/.baserc中配置默认vim为neovim"alias vim='nvim',alias vi='nvim'"

7.windows子系统wsl中使用clip.exe拷贝到系统剪切板,虚拟机安装xsel工具即可

8. 使用语法增强插件treesitter 需要安装gcc,g++, gcc支持32位编译 sudo apt-get install gcc-multilib g++-multilib

9. python需要安装nodejs, npm
    sudo apt-get install nodejs
    sudo apt-get install npm
    -- 期间要关闭fastgithub中修改的环境变量中的http_proxy和https_proxy,
    unset http_proxy
    unset https_proxy
    -- 更新nodejs和npm
    sudo npm install -g n  -- 安装n模块
    sudo n stable  -- 升级nodejs到最新的stable(稳定版)
    sudo npm install npm -location=global
    nvim中使用npm时环境变量http_proxy/https_proxy也不能有
    -- 若需要安装 typescripy typescript-language-server 
    sudo npm install --location=global typescript typescript-language-server

10.支持具体语言查看: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

11.安装bear,用来生成clangd(c/c++)依赖的配置文件'compile_commands.json'
    sudo apt-get install bear
    bear 后面跟编译命令即可
    bear $make
    就可以生成'compile_commands.json文件了,然后lsp中的clangd就能更好用了
    编译出错可以使用gf跳转到文件出错的那一行

12.更换apt源 sudo vim /etc/apt/source.list 换后gcc有问题,只能用来安装bear,再换回去
    deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
    deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
    deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
    deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
    deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
    deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
    deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
    deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
    deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
    deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
    -- 若缺少公钥
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32
    3B4FE6ACC0B21F32是缺少的密钥，缺少什么就下什么

13.gen_tags 需要安装ctags 和 GNU-Global(cscope 替代升级版)
    sudo apt-get install universal-ctags
    sudo apt-get install global
    使用时:nvim打开代码后命令行输入
    :GenCtags   生成ctags数据库,即可跳转<C-]>
    :ClearCtags 删除生成的ctags, 加叹号remove all files, include the db dir
    :EditExit 编辑ctags数据库,可以添加第三方库,如输入:ls -s /user/include/ . 即可链接三方库
    :GenGTAGS   生成类似cscope的数据库

    Ctrl+\c查找调用此函数的函数
    Ctrl+\d查找此函数调用的函数
    Ctrl+\e查找匹配字符
    Ctrl+\f查找此文件
    Ctrl+\g查找此定义
    Ctrl+\i查找文件#包括此文件
    Ctrl+\s查找此C符号
    Ctrl+\t查找此文本字符串
