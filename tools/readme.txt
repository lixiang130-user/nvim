1.fastgithub工具下载:https://fastgithub.cn/download
2.neovim下载:https://github.com/neovim/neovim/releases/nightly
3.工具放到~/.user_tools下
4.配置neovim信息放到~/.config/nvim/下
5.clone 插件packer,保存路径固定在~/.config下,想要修改路径比较困难
    git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

6.~/.bashrc中配置默认vim为neovim"alias vim='nvim',alias vi='nvim'"

7.windows子系统wsl中使用clip.exe拷贝到系统剪切板,虚拟机安装xsel工具即可

8. 使用语法增强插件treesitter 需要安装gcc,g++, gcc支持32位编译 sudo apt-get install gcc-multilib g++-multilib

9. lsp解析python和json需要安装npm,
    sudo apt-get install npm
    使用npm期间要 unset https_proxy
    若需要安装nodejs
    sudo apt-get install nodejs
    -- 期间要关闭fastgithub中修改的环境变量中的http_proxy和https_proxy,
    unset http_proxy
    unset https_proxy
    -- 更新nodejs和npm
    sudo npm install -g n  -- 安装n模块
    sudo n stable  -- 升级nodejs到最新的stable(稳定版)
    sudo npm install npm -location=global   --升级npm到最新版本
    nvim中使用npm时环境变量http_proxy/https_proxy也不能有
    -- 若需要安装 typescripy typescript-language-server 
    sudo npm install --location=global typescript typescript-language-server

10.支持具体语言查看: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

11.安装bear,用来生成clangd(c/c++)依赖的配置文件'compile_commands.json'
    sudo apt-get install bear
    bear 后面跟编译命令即可
    bear $make  #bear 3.版本后使用 bear -- make 指令
    启动了fastgithub代理bear -- make出问题,unset http(s)_proxy就行了
    就可以生成'compile_commands.json文件了,然后lsp中的clangd就能更好用了
    编译出错可以使用gf跳转到文件出错的那一行

12.telescope 望远镜插件可以查找文件,字符串等,需要安装工具ripgrep才能使用live_grep
    sudo apt-get install ripgrep
