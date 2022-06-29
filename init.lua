-- 加载文件
-- 加载其他lua配置文件:basic.lua文件
-- require('basic')

-- 配置
vim.g.encoding = "UTF-8"    -- utf8
vim.o.fileencoding = "utf-8"

vim.o.tabstop = 4   -- 缩进4个空格等于一个Tab
vim.bo.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftround = true
vim.o.shiftwidth = 4    -- >> << 时移动长度
vim.bo.shiftwidth = 4
vim.o.expandtab = true    -- 空格替代tab
vim.bo.expandtab = true
vim.o.autoread = true     -- 文件被外部程序修改时,自动加载
vim.bo.autoread = true 
vim.o.wrap = true    -- 允许折行
vim.wo.wrap = true
-- vim.api.nvim_command('set nu')  -- 展示行号,调用vim设置的方式
vim.wo.number = true      -- 展示行号
vim.wo.relativenumber = false   -- 展示相对行号
vim.o.hlsearch = true     -- 搜索高亮
vim.o.incsearch = true    -- 边输入边搜索
vim.o.mouse = 'a'   -- 支持鼠标
vim.o.backup = false    -- 禁止创建备份文件
vim.o.writebackup = false
vim.o.swapfile = false
-- vim.o.updatetime = 300   -- smaller updatetime
-- vim.o.timeoutlen = 500   -- 设置 timeoutlen 为等待键盘快捷键连击时间500毫秒,可根据需要设置
vim.o.splitbelow = true   -- split window 从下边和右边出现
vim.o.splitright = true
vim.g.completeopt = "menu,menuone,noselect,noinsert"    -- 自动补全不自动选中
vim.o.list = false    -- 是否显示不可见字符
vim.o.listchars = "space:·,tab:··"    -- 不可见字符的显示,这里只把空格显示为一个点
vim.o.wildmenu = true   -- 补全增强
vim.o.pumheight = 10    -- 补全最多显示10行
vim.o.showtabline = 2   -- 默认情况下,只有用户新建了标签页才会在窗口上方显示标签栏,
                        -- 这是由选项set showtabline=1决定的。如果我们希望总是显示标签栏,
                        -- 那么可以用set showtabline=2命令来设置。如果我们希望完全不显示标签栏,
                        -- 那么可以使用set showtabline=0来设置。

vim.o.showmode = false  -- 显示当前模式nvi,使用增强状态栏插件后不再需要 vim 的模式提示
vim.wo.colorcolumn = "80"   -- 右侧参考线，超过表示代码太长了，考虑换行
vim.o.termguicolors = true  -- 主题样式
vim.opt.termguicolors = true



-- 配置快捷键的常用前缀,通常是空格,后面见到<leader>就表示空格
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- 设备本地变量
local map = vim.api.nvim_set_keymap
local opt = {noremap = true, silent = true }
-- 这样就可样映射按键了:
-- map('模式','按键','映射为xx',opt)
map('n', 'ca', ':wqa<CR>', opt)     -- ca(close all)关闭所有窗口并退出
map('n', 'cc', '<C-w>c', opt)       -- cc(close)关闭当前窗口
map('n', 'co', '<C-w>o', opt)       -- co(close others)关闭其他窗口
map('n', 'wv', ':vsp<CR>', opt)     -- wv(windows vertical split)垂直分屏
map('n', 'ws', ':sp<CR>', opt)      -- ws(windows split)水平分屏
map('n', 'w.', ':resize +3<CR>', opt)   -- w.窗口上下大小增加3
map('n', 'w,', ':resize -3<CR>', opt)   -- w.窗口上下大小减小3
map('n', 'w=', ':vertical resize +3<CR>', opt)  -- w.窗口左右大小增加3
map('n', 'w-', ':vertical resize -3<CR>', opt)  -- w.窗口左右大小减小3
map('n', '<C-h>', '<C-w>h', opt)    -- ctrl+hjkl替换ctrl-w +hjkl 切换窗口
map('n', '<C-j>', '<C-w>j', opt)
map('n', '<C-k>', '<C-w>k', opt)
map('n', '<C-l>', '<C-w>l', opt)

--加载导入的lua,写入路径
package.path = package.path..';./plugged/packer.nvim/lua/?.lua'
package.path = package.path..';./plugged/packer.nvim/lua/packer/?.lua'
require('packer').startup(function()
    -- Packer can manage itself 包工具可以管理自己
    use 'wbthomason/packer.nvim'
end)
-- packer是管理插件的插件,通常更新插件只需要一个命令:PackerSync
