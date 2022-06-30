---------------- 快捷键配置 ----------------
-- 按键映射定义
-- <k0> - <k9> 小键盘 0 到 9
-- <S-...> Shift＋键
-- <C-...> Control＋键
-- <M-...> Alt＋键 或 meta＋键
-- <A-...> 同 <M-...>
-- <Esc> Escape 键
-- <Up> 光标上移键
-- <Space> 插入空格
-- <Tab> 插入Tab
-- <CR> 等于<Enter>
-- 普通模式 (Normal Mode) n
-- 插入模式 (Insert Mode) i
-- 可视模式 (Visual Mode) v
-- 命令模式 (Command Mode) c
-- 配置快捷键的常用前缀,通常是空格,后面见到<leader>就表示空格
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- 设备本地变量 这样就可样映射按键了: map('模式','按键','映射为xx',opt)
local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }
-- 分屏操作
map('n', 'wv', ':vsp<CR>', opt) -- wv(windows vertical split)垂直分屏
map('n', 'ws', ':sp<CR>', opt) -- ws(windows split)水平分屏
map('n', 'w.', ':resize +3<CR>', opt) -- w.窗口上下大小增加3
map('n', 'w,', ':resize -3<CR>', opt) -- w.窗口上下大小减小3
map('n', 'w=', ':vertical resize +3<CR>', opt) -- w.窗口左右大小增加3
map('n', 'w-', ':vertical resize -3<CR>', opt) -- w.窗口左右大小减小3
-- 关闭窗口操作
map('n', 'ca', ':wa<CR>:qa<CR>', opt) -- ca(close all)关闭所有窗口并退出
map('n', 'cc', '<C-w>c', opt) -- cc(close)关闭当前窗口
map('n', 'co', '<C-w>o', opt) -- co(close others)关闭其他窗口
map('n', '<C-h>', '<C-w>h', opt) -- ctrl+hjkl替换ctrl-w +hjkl 切换窗口
map('n', '<C-j>', '<C-w>j', opt)
map('n', '<C-k>', '<C-w>k', opt)
map('n', '<C-l>', '<C-w>l', opt)
-- nvimtree插件打开目录树
map('n', 'wm', ':NvimTreeToggle<CR>', opt) -- 映射wm为启动关闭nvimtree功能
-- bufferline插件操作
map("n", "<S-h>", ":BufferLineCyclePrev<CR>", opt) -- bufferline 左右Shift切换
map("n", "<S-l>", ":BufferLineCycleNext<CR>", opt)
map("n", "cw", ":bw!<CR>", opt) -- close windows 关闭当前窗口(bw or bd)
map("n", "cl", ":BufferLineCloseLeft<CR>", opt) -- close left 关闭当前窗口左侧所有窗口
map("n", "cr", ":BufferLineCloseRight<CR>", opt) -- close right 关闭当前窗口右侧所有窗口
-- terminal终端操作
map("t", "<Esc>", "<C-\\><C-n>", opt) -- 命令行模式下terminal输入模式下切换到正常模式
map("n", "tt", ":vsp<CR>:terminal<CR>", opt) -- terminal 开启终端
-- 剪切板操作 wsl子系统无法使用xsel实现剪切板,但是可以用过clip.exe实现系统剪切板:
map("v", "Y", "!clip.exe<CR>u", opt) -- 通过wsl中的clip.exe拷贝内容到系统剪切板
                                        -- 但是会删除背拷贝的内容,所以使用u撤销


