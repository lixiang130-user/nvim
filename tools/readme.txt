1.fastgithub工具下载:https://fastgithub.cn/download
2.neovim下载:https://github.com/neovim/neovim/releases/nightly
3.工具放到~/.user_tools下
4.配置neovim信息放到~/.config/nvim/下
5.clone 插件packer,保存路径固定在~/.config下,想要修改路径比较困难
    git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

6.packer管理插件的插件:https://github.com/wbthomason/packer.nvim

7.~/.baserc中配置默认vim为neovim"alias vim='nvim',alias vi='nvim'"

8.windows子系统wsl中使用clip.exe拷贝到系统剪切板,虚拟机安装xsel工具即可
