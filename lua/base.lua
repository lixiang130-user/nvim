---------------- 基础配置 ----------------
-- 调用vim中的配置命令方式: vim.api.nvim_command('set nu')  -- 展示行号
vim.g.encoding = 'UTF-8' -- utf8
vim.o.fileencoding = 'utf-8'
vim.o.scrolloff = 5 -- jk移动时光标下上方保留x行
vim.o.sidescrolloff = 5
vim.o.tabstop = 4 -- 缩进4个空格等于一个Tab
vim.bo.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftround = true
vim.o.shiftwidth = 4 -- >> << 时移动长度
vim.bo.shiftwidth = 4
vim.o.expandtab = true -- 空格替代tab
vim.bo.expandtab = true
vim.o.autoread = true -- 文件被外部程序修改时,自动加载
vim.bo.autoread = true
vim.o.wrap = false -- 允许折行,一行展示不全时换行展示
vim.wo.wrap = false
vim.wo.number = true -- 展示行号
vim.wo.relativenumber = false -- 展示相对行号
vim.o.hlsearch = true -- 搜索高亮
vim.o.mouse = 'a' -- 支持鼠标
vim.o.backup = false -- 禁止创建备份文件
vim.o.writebackup = false
vim.o.swapfile = false
-- vim.o.updatetime = 300   -- smaller updatetime
-- vim.o.timeoutlen = 500   -- 设置 timeoutlen 为等待键盘快捷键连击时间500毫秒,可根据需要设置
vim.o.splitbelow = true -- split window 从下边和右边出现
vim.o.splitright = true
vim.g.completeopt = 'menu,menuone,noselect,noinsert' -- 自动补全不自动选中
vim.o.wildmenu = true -- 补全增强
vim.o.pumheight = 10 -- 补全最多显示10行
vim.o.list = true -- 是否显示不可见字符
vim.o.listchars = 'space:·,tab:··' -- 不可见字符的显示,这里只把空格显示为一个点
vim.o.showmode = false -- 显示当前模式nvi,使用增强状态栏插件后不再需要 vim 的模式提示
vim.wo.colorcolumn = '80' -- 右侧参考线，超过表示代码太长了，考虑换行
vim.o.cmdheight = 1 -- 命令行高为2，提供足够的显示空间
vim.o.ignorecase = true -- 搜索大小写不敏感，除非包含大写
vim.o.smartcase = true

vim.api.nvim_command('set cursorline')  --编辑的折行添加下划线,背景色
-- 折叠功能 za 打开/关闭,zc,zo关闭,打开,zr,zm打开,关闭所有折叠,zR,zM打开,关闭所有嵌套折叠
-- zd,zE,删除当前,所有折叠, zj,zk,移动至上,下一个折叠,zn,zN禁用,启动,折叠
vim.api.nvim_command('set foldmethod=indent')   -- 创建折叠,缩进大于99的都被折叠
vim.api.nvim_command('set foldlevel=99')    -- 这样就可以使用zc,zo折叠和打开了
-- 插入递增数,递减数, ctrl-a, ctrl-x, g键是与之前的数字关联,从x开始,间隔y个数递增递减等
-- ctrl-v选中数字x,num_y+g+ctrl-a/x 即可,
-- 或仍然ctrl-a选中,执行:let i=0 | g/1/s//\=i/ | let i=i+1
--[[                    vim 中使用零宽度断言，包括
符号        vim表符号       描述                示例            vim 示例
?=          \@=	        正先行断言 - 存在	foo(?=bar)	    foo\(bar\)\@=
?!	        \@!	        负先行断言 - 排除	foo(?!bar)	    foo\(bar\)\@!
?<=	        \@<=	    正后发断言 - 存在	(?<=foo)bar	    \(foo\) \@<=bar
?<!	        \@<!	    负后发断言 - 排除	(?<!foo)bar	    \(foo\) \@<!bar     ]]--
