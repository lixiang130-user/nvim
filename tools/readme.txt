1.fastgithub工具下载:https://fastgithub.cn/download
2.neovim下载:https://github.com/neovim/neovim/releases/nightly
3.工具放到~/.user_tools下
4.配置neovim信息放到~/.config/nvim/下
5.clone 插件packer,保存路径固定在~/.config下,想要修改路径比较困难
    git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

6.packer管理插件的插件:https://github.com/wbthomason/packer.nvim

7.~/.baserc中配置默认vim为neovim"alias vim='nvim',alias vi='nvim'"

8.windows子系统wsl中使用clip.exe拷贝到系统剪切板,虚拟机安装xsel工具即可

9. 使用语法增强插件treesitter 需要安装gcc,g++

10. python需要安装nodejs, npm
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

11.支持具体语言查看: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
