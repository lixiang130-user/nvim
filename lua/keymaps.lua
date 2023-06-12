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
-- ctrl-ww可以进入悬浮窗,再次按下退出悬浮窗
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- 设备本地变量 这样就可样映射按键了: map('模式','按键','映射为xx',opt)
local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

-- leap 插件按键配置
vim.keymap.set({'n', 'x', 'o'}, 'f', '<Plug>(leap-forward-to)') --向后查找
vim.keymap.set({'n', 'x', 'o'}, 'F', '<Plug>(leap-backward-to)')    --向前查找
vim.keymap.set({'n', 'x', 'o'}, 'gf', '<Plug>(leap-from-window)')    --查找别的窗口

-- interestingwords高量插件,按键配置
vim.g.interestingWordsDefaultMappings = 1
-- map("n", "<leader>k", ":call InterestingWords('n')<cr>", opt)
-- map("v", "<leader>k", ":call InterestingWords('v')<cr>", opt)
-- map("n", "<leader>K", ":call UncolorAllWords()<cr>", opt)
-- map("n", "n", ":call WordNavigation(1)<cr>", opt)
-- map("n", "N", ":call WordNavigation(0)<cr>", opt)
-- 要配置 GUI 的颜色
-- vim.g.interestingWordsGUIColors = {'#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF'}

-- map("n", "<leader>gd", ":set nohlsearch<cr>", opt) -- 取消搜索高亮
-- map("n", "<leader>gd", ":set hlsearch<cr>", opt) -- 打开搜索高亮
map("n", "<leader>gd", "/\\w\\{999\\}<cr>", opt) -- 取消搜索高亮
map("n", "gd", "\"zyiwk/\\<<C-r>z\\><cr>", opt) -- 复制当前光标单词到寄存器z,在搜索\<xxxx\>

-- lvimgrep "xxxx" % <cr> :lopen<cr> 当前文件搜索字符串xxx并窗口打开搜索结果
-- 命令模式下的百分号 是当前文件的文件名, <C-r>/ 是粘贴搜索模式寄存器
-- https://www.codenong.com/509690/ 搜索结果列表出窗口教程
map("n", "<leader>/", ":lvimgrep \"<C-r>/\" %<CR>:lopen<CR>", opt);
-- 指定复制粘贴寄存器双引号变单引号, "xy "xp 指定任意字母x为复制粘贴寄存器
map("n", "'", "\"", opt)
map("v", "'", "\"", opt)
-- 分屏操作
map('n', 'wv', ':vsp<CR>', opt) -- wv(windows vertical split)垂直分屏
map('n', 'ws', ':sp<CR>', opt) -- ws(windows split)水平分屏
-- map('n', 'w=', ':resize +3<CR>', opt) -- w.窗口上下大小增加3
-- map('n', 'w-', ':resize -3<CR>', opt) -- w.窗口上下大小减小3
-- map('n', 'w.', ':vertical resize +3<CR>', opt) -- w.窗口左右大小增加3
-- map('n', 'w,', ':vertical resize -3<CR>', opt) -- w.窗口左右大小减小3
map('n', 'w=', '<C-w>3+', opt) -- w.窗口上下大小增加3
map('n', 'w-', '<C-w>3-', opt) -- w.窗口上下大小增加3
map('n', 'w.', '<C-w>3>', opt) -- w.窗口上下大小增加3
map('n', 'w,', '<C-w>3<', opt) -- w.窗口上下大小增加3
-- 保存文件
map('n', 'ww', ':wa<CR>', opt)
map('n', 'wa', ':wa<CR>', opt)
-- 关闭窗口操作
map('n', 'ca', ':wa<CR>:qa<CR>', opt) -- ca(close all)关闭所有窗口并退出
map('n', 'cc', '<C-w>c', opt) -- cc(close)关闭当前窗口
-- map('n', 'co', '<C-w>o', opt) -- co(close others)关闭其他窗口
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
map("n", "<S-k>", ":BufferLineCyclePrev<CR>", opt) -- bufferline 左右Shift切换
map("n", "<S-j>", ":BufferLineCycleNext<CR>", opt)
map("n", "cii", ":bw!<CR>", opt) -- close windows 关闭当前窗口(bw or bd)
map("n", "cl", ":BufferLineCloseLeft<CR>", opt) -- close left 关闭当前窗口左侧所有窗口
map("n", "cr", ":BufferLineCloseRight<CR>", opt) -- close right 关闭当前窗口右侧所有窗口
map('n', 'co', ':BufferLineCloseLeft<CR>:BufferLineCloseRight<CR>', opt) -- co(close others)关闭其他窗口
-- terminal终端操作
map("t", "<Esc>", "<C-\\><C-n>", opt) -- 命令行模式下terminal输入模式下切换到正常模式
map("t", "<C-[>", "<C-\\><C-n>", opt)
map("i", "<C-【>", "<C-\\><C-n>", opt)
map("n", "tt", ":sp<CR>:terminal<CR>", opt) -- terminal 开启终端
map("n", "ts", ":sp<CR>:terminal<CR>", opt) -- terminal 开启终端
map("n", "tv", ":vsp<CR>:terminal<CR>", opt) -- terminal 开启终端
-- 剪切板操作 wsl子系统无法使用xsel实现剪切板,但是可以用过clip.exe实现系统剪切板:
-- map('v', 'Y', '"+y', opt)   -- mac下复制到剪切板
-- map("v", "Y", ":w !clip.exe<CR><CR>", opt) -- 通过wsl中的clip.exe拷贝内容到系统剪切板,只读文件也可以复制
map("v", "Y", ":w !uclip.exe<CR><CR>", opt) -- 通过wsl中的clip.exe拷贝内容到系统剪切板,只读文件也可以复制
-- map("v", "Y", ":w !xsel<CR><CR>", opt)
-- map("v", "Y", "!clip.exe<CR>u", opt) -- 通过wsl中的clip.exe拷贝内容到系统剪切板
                                    -- 但是会删除背拷贝的内容,所以使用u撤销,而且只读文件不能复制

-- telescope(望远镜) 强大的文件搜索 预览, 可以通过命令和函数的方式调用
map('n', '<leader>ts', '<cmd>Telescope<CR>', opt)   -- 调用telescope
-- 查找文件 lsp解析的文件
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', opt)    -- 查找文件
-- 查找字符串 类似grep精准方式
map('n', '<leader>fg', '<cmd>lua require(\'telescope.builtin\').live_grep()<CR>', opt)
-- 查找符号,lsp解析过的符号表,不能找到每一处
map('n', '<leader>fs', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>', opt)
-- <C-q> 将所有未过滤的条目,发送到qlist(在屏幕下方的小窗口,类似以前的cw弹出小窗口)

-- vim-translator 插件, <ctrl-w>p可以进入翻译悬浮窗,再次按下退出
-- 翻译结果展示在命令行
map('v', '<leader>ft', ':Translate<CR>', opt)
map('n', '<leader>ft', ':Translate<CR>', opt)
-- 翻译结果展示在悬浮窗
map('v', '<leader>fw', ':TranslateW<CR>', opt)
map('n', '<leader>fw', ':TranslateW<CR>', opt)
-- 翻译结果替换原文本(不可用)
map('v', '<leader>fr', ':TranslateR<CR>', opt)
map('n', '<leader>fr', ':TranslateR<CR>', opt)
-- 翻译终端输入的文本
map('n', '<leader>fx', ':TranslateX ', opt)
-- 中英文翻译互换 fc convert 转换
local t_src_eq_en = 'vim.g.translator_source_lang == \'en-us\''
local t_src_cn = 'vim.g.translator_source_lang = \'zh-cn\''
local t_tar_en = 'vim.g.translator_target_lang = \'en-us\''
local t_src_en = 'vim.g.translator_source_lang = \'en-us\''
local t_tar_cn = 'vim.g.translator_target_lang = \'zh-cn\''
local t_map_cmd = ':lua if '..t_src_eq_en..' then '..t_src_cn..' '..t_tar_en..' else '..t_src_en..' '..t_tar_cn..' end<CR>'
vim.g.translator_target_lang = 'zh-cn'
vim.g.translator_source_lang = 'en-us'
map('v', '<leader>fc', t_map_cmd, opt)
map('n', '<leader>fc', t_map_cmd, opt)

-- 自动等价排列所有窗口 windows (not) eq
map('n', 'we', ":set noequalalways<CR>:set equalalways<CR>", opt)
map('n', 'wn', ":set noequalalways<CR>", opt)

-- lspconfig keymap
local pluginKeys = {}
pluginKeys.lsp_map = function()
    -- 参考文献,类似查找功能,查到单词级别的所有出现的地方
    map('n', '<leader>r', '<cmd>lua vim.lsp.buf.references()<CR>', opt)
    -- 跳转到定义处,还可以跳转到文件
    map('n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opt)
    map('n', '<leader>d', '<cmd>lua vim.lsp.buf.definition()<CR>', opt)
    -- 跳转到头文件声明
    map('n', '<leader>D', '<cmd>lua vim.lsp.buf.declaration()<CR>', opt)
    -- 关闭诊断,当前行诊断,等待,交换参数位置等常用功能,展开宏定义等
    map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opt)
    -- 格式化 不好用,全乱了
    map('n', '<leader>=', '<cmd>lua vim.lsp.buf.format()<CR>', opt)
    map('v', '<leader>=', '<cmd>lua vim.lsp.buf.format()<CR>', opt)

    -- 展示语法提示警告错误内容 当前,上一个,下一个提示内容, 展示所有提示语
    map('n', '<leader>o', '<cmd>lua vim.diagnostic.open_float()<CR>', opt)
    map('n', '<leader>p', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opt)
    map('n', '<leader>n', '<cmd>lua vim.diagnostic.goto_next()<CR>', opt)
    map('n', '<leader>s', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)

    map('n', '<leader>h', '<cmd>lua vim.lsp.buf.hover()<CR>', opt)  -- 悬浮窗展示定义详情
    map('n', '<leader>i', '<cmd>lua vim.lsp.buf.implementation()<CR>', opt)
    -- map('n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opt) -- 查看签名帮助
    -- map('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
    -- map('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
    -- map('n', '<leader>wl', '<cmd>lua function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end()<CR>', opt)
   -- goto type def跳转到定义处
    map('n', '<leader>td', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opt)
    -- map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opt)    -- 变量重命名
end

-- nvim-cmp 自动补全
pluginKeys.cmp = function(cmp)
    return {
        -- 上一个
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        -- 下一个
        ['<C-n>'] = cmp.mapping.select_next_item(),
        -- 出现补全
        ['<A-.>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        -- 取消
        ['<A-,>'] = cmp.mapping({i = cmp.mapping.abort(), c = cmp.mapping.close(),}),
        -- 确认,接受当前选定的项目。如果未选择任何项，则“选择”第一项。
        -- 将“选择”设置为“false”以仅确认显式选择的项目。
        ['<CR>'] = cmp.mapping.confirm({select = false}),
        --['<C-y>']=cmp.config.disable,--如果要删除默认的'<C-y>'映射,请指定'cmp.config.disable'
        ['<C-u>'] = cmp.config.disable,
        ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }), --二级界面注释翻页
        ['<C-d>'] = cmp.config.disable,
        ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' })   --二级界面注释翻页
    }
end

-- nvim-tree 按键映射
pluginKeys.nvim_tree = function(bufnr)
    local api = require('nvim-tree.api')
    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    -- copy default mappings here from defaults in next section
    vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node,          opts('CD'))
    vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer,     opts('Open: In Place'))
    -- 或者使用所有默认映射
    -- api.config.mappings.default_on_attach(bufnr)
    -- 删除默认值
    -- vim.keymap.del('n', '<C-]>', { buffer = bufnr })
    -- 添加你的映射 :help nvim-tree-mappings
    vim.keymap.set('n', 'a',        api.fs.create,          opts('Create'))
    vim.keymap.set('n', 'r',        api.fs.rename,          opts('Rename'))
    vim.keymap.set('n', 'X',        api.fs.cut,             opts('Cut'))
    vim.keymap.set('n', 'C',        api.fs.copy.node,       opts('Copy'))
    vim.keymap.set('n', 'V',        api.fs.paste,           opts('Paste'))
    vim.keymap.set('n', 'p',        api.fs.paste,           opts('Paste'))
    vim.keymap.set('n', 'd',        api.fs.remove,          opts('Delete'))
    vim.keymap.set('n', '<CR>',     api.node.open.edit,     opts('Open'))
    vim.keymap.set('n', 'o',        api.node.open.edit,     opts('Open'))
end


do return pluginKeys end

