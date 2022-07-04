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
vim.o.wrap = true -- 允许折行,一行展示不全时换行展示
vim.wo.wrap = true
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
vim.api.nvim_command('set cursorline')  --编辑的折行添加下划线,背景色
