---------------- 基础配置 ----------------
-- 调用vim中的配置命令方式: vim.api.nvim_command('set nu')  -- 展示行号
vim.g.encoding = 'UTF-8' -- utf8
vim.o.fileencoding = 'utf-8'
vim.o.scrolloff = 5 -- jk移动时光标下上方保留x行
vim.o.sidescrolloff = 5
vim.o.shiftround = true
vim.o.shiftwidth = 4 -- >> << 时移动长度
vim.bo.shiftwidth = 4
vim.o.expandtab = true -- 空格替代tab
vim.bo.expandtab = true
vim.o.tabstop = 4 -- 缩进4个空格等于一个Tab
vim.bo.tabstop = 4
vim.o.softtabstop = 4
vim.o.autoread = true -- 文件被外部程序修改时,自动加载
vim.bo.autoread = true
vim.o.wrap = false -- 允许折行,一行展示不全时换行展示   :set nowrap/wrap 临时控制换行
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

vim.api.nvim_command('set noequalalways')   -- 禁止开关多窗口时自动调整窗口大小
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
?<!	        \@<!	    负后发断言 - 排除	(?<!foo)bar	    \(foo\) \@<!bar
正则表达式的或 "|",vim中要转移 "\|" 例如: \(ui_\|mem_\)\@<!free(
grep 使用领款断言执行 grep -oP "(?<=xx)xxxxx(?=xx)"
]]--

-- 复制粘贴指定寄存器: 复制: "xy 粘贴: "xp 其中"就是引号按键",插入模式下粘贴可以<c-r>x的方式粘贴
-- x可以使任意字母或数字, 但是1-9数字是最近删除的文本,0号数字是最近复制的文本,会被系统不断覆盖
-- '/' 是搜索模式寄存器(Search Pattern Register)当通过/命令进行搜索时,所使用的模式将被自动放入"/寄存器。
-- 计算器,指令模式输入":=x+x*x-x/x"回车,输入模式"<C-r>=x+x-x/x*"回车

-- 设置vim terminal的最大回滚行号,默认9999,最大目前只能到100000
vim.api.nvim_command('set scrollback=100000')
-- makefile中tab也可以替换成四个空格
-- 但是makefile语法要求许多缩进需要时tab,而不能是空格!!!!
--vim.api.nvim_create_autocmd("FileType", {
--    pattern = "make",
--    command = "setlocal expandtab"
--})
