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
map('n', 'wm', ':NvimTreeToggle<CR>', opt)
-- vista插件打开大纲
map('n', 'vm', ':Vista!!<CR>', opt)
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
map("v", "Y", ":w !clip.exe<CR><CR>", opt) -- 通过wsl中的clip.exe拷贝内容到系统剪切板,只读文件也可以复制
-- map("v", "Y", "!clip.exe<CR>u", opt) -- 通过wsl中的clip.exe拷贝内容到系统剪切板
                                    -- 但是会删除背拷贝的内容,所以使用u撤销,而且只读文件不能复制

-- gen_tags
-- GenCtags + GenGTAGS 生成tags+global(类似cscope)链接文件
map('n', 'gts', ':GenCtags<CR>:GenGTAGS<CR>', opt)
-- EditExt 编辑ctags数据库,可以添加第三方库,如输入:ls -s /user/include/ . 即可链接三方库
map('n', 'gte', ':EditExt<CR>', opt)
-- ClearCtags(!) + ClearCTAGS(!) 删除生成的tags+global,!删除全部
map('n', 'gtc', ':ClearCtags!<CR>:ClearGTAGS!<CR>', opt)
    -- 跳转<C-]>
    -- Ctrl+\c查找调用此函数的函数
    -- Ctrl+\d查找此函数调用的函数
    -- Ctrl+\e查找匹配字符
    -- Ctrl+\f查找此文件
    -- Ctrl+\g查找此定义
    -- Ctrl+\i查找文件#包括此文件
    -- Ctrl+\s查找此C符号
    -- Ctrl+\t查找此文本字符串

-- lspconfig keymap
local pluginKeys = {}
pluginKeys.lsp_map = function()
    -- 参考文献,类似查找功能,查到单词级别的所有出现的地方
    map('n', '<leader>r', '<cmd>lua vim.lsp.buf.references()<CR>', opt)
    -- 跳转到定义处,还可以跳转到文件
    map('n', '<leader>d', '<cmd>lua vim.lsp.buf.definition()<CR>', opt)
    -- 跳转到头文件声明
    map('n', '<leader>D', '<cmd>lua vim.lsp.buf.declaration()<CR>', opt)
    -- 关闭诊断,当前行诊断,等待,交换参数位置等常用功能,展开宏定义等
    map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opt)
    -- 格式化
    map('n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opt)

    -- 展示语法提示警告错误内容 当前,上一个,下一个提示内容, 展示所有提示语
    map('n', '<leader>o', '<cmd>lua vim.diagnostic.open_float()<CR>', opt)
    map('n', '<leader>p', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opt)
    map('n', '<leader>n', '<cmd>lua vim.diagnostic.goto_next()<CR>', opt)
    map('n', '<leader>s', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)

    map('n', '<leader>h', '<cmd>lua vim.lsp.buf.hover()<CR>', opt)  -- 悬浮窗展示定义详情
    map('n', '<leader>i', '<cmd>lua vim.lsp.buf.implementation()<CR>', opt)
    map('n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opt) -- 查看签名帮助
    -- map('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
    -- map('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
    -- map('n', '<leader>wl', '<cmd>lua function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end()<CR>', opt)
   -- goto type def跳转到定义处
    map('n', '<leader>td', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opt)
    -- map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opt)    -- 变量重命名
end
do return pluginKeys end
