-- 加载其他配置文件方式 require('basic')
-- 调用vim中的配置命令方式: vim.api.nvim_command('set nu')  -- 展示行号

---------------- 基础配置 ----------------
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
vim.o.list = false -- 是否显示不可见字符
vim.o.listchars = 'space:·,tab:··' -- 不可见字符的显示,这里只把空格显示为一个点
vim.o.showmode = false -- 显示当前模式nvi,使用增强状态栏插件后不再需要 vim 的模式提示
vim.wo.colorcolumn = '80' -- 右侧参考线，超过表示代码太长了，考虑换行


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
-- lsp 快捷键设置
function Lsp_keybind_map(mapbuf)
    mapbuf('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opt) -- rename
    mapbuf('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opt) -- 代码操作
    mapbuf('n', '<space>d', '<cmd>lua vim.lsp.buf.definition()<CR>', opt) -- go 定义
    mapbuf('n', '<space>h', '<cmd>lua vim.lsp.buf.hover()<CR>', opt) -- go 定义,悬浮窗方式
    mapbuf('n', '<space>D', '<cmd>lua vim.lsp.buf.declaration()<CR>', opt) -- go 公告
    mapbuf('n', '<space>i', '<cmd>lua vim.lsp.buf.implementation()<CR>', opt) -- go 实施
    mapbuf('n', '<space>r', '<cmd>lua vim.lsp.buf.references()<CR>', opt) -- go 参考文献,调用等
    mapbuf('n', '<space>o', '<cmd>lua vim.diagnostic.open_float()<CR>', opt) -- 诊断 xx
    mapbuf('n', '<space>p', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opt)
    mapbuf('n', '<space>n', '<cmd>lua vim.diagnostic.goto_next()<CR>', opt)
    -- mapbuf('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
    mapbuf('n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opt)  -- 格式化
    -- mapbuf('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opt)
    -- mapbuf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
    -- mapbuf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
    -- mapbuf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
    -- mapbuf('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opt)
end
function Lsp_cmp(lcmp)
    return {
        -- 上一个
        ['<C-k>'] = lcmp.mapping.select_prev_item(),
        -- 下一个
        ['<C-j>'] = lcmp.mapping.select_next_item(),
        -- 出现补全
        ['<A-.>'] = lcmp.mapping(lcmp.mapping.complete(), { 'i', 'c' }),
        -- 取消
        ['<A-,>'] = lcmp.mapping({
            i = lcmp.mapping.abort(),
            c = lcmp.mapping.close(),
        }),
        -- 确认 接受当前选定的项目。如果未选择任何项，则“选择”第一项。
        -- 将“选择”设置为“false”以仅确认显式选择的项目。
        ['<CR>'] = lcmp.mapping.confirm({
            select = true ,
            behavior = lcmp.ConfirmBehavior.Replace
        }),
        -- ['<C-y>'] = lcmp.config.disable
        -- 如果要删除默认的“<C-y>”映射，请指定“lcmp.config.disable”。
        ['<C-u>'] = lcmp.mapping(lcmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-d>'] = lcmp.mapping(lcmp.mapping.scroll_docs(4), { 'i', 'c' }),
    }
end



---------------- 插件管理配置 ----------------
-- packer是管理插件的插件,通常更新插件只需要一个命令:PackerSync
require('packer').startup(function()
    -- Packer can manage itself 包工具可以管理自己
    use 'wbthomason/packer.nvim'
    -- gruvbox theme
    -- use {'ellisonleao/gruvbox.nvim', requires = {'rktjmp/lush.nvim'}}
    -- nord theme
    -- use 'shaunsingh/nord.nvim'
    -- zephyr-nvim theme
    use 'glepnir/zephyr-nvim'
    -- treesitter 语法高亮, :TSInstallInfo查看支持的语言
    -- :TSInstall lua,安装语言解析器, :TSBufToggle highlight 可根据语法高亮显示
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    -- nvim-tree 插件,打开文件树
    use { 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons' }
    -- bufferline 插件,展示顶部tab标签
    use { 'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons' }
    -- lsp 功能:自动补全，跳转到定义，查找引用，悬停文档提示等功能
    use { 'neovim/nvim-lspconfig', 'williamboman/nvim-lsp-installer' }
      -- nvim-cmp
    use 'hrsh7th/cmp-nvim-lsp' -- { name = nvim_lsp }
    use 'hrsh7th/cmp-buffer'   -- { name = 'buffer' },
    use 'hrsh7th/cmp-path'     -- { name = 'path' }
    use 'hrsh7th/cmp-cmdline'  -- { name = 'cmdline' }
    use 'hrsh7th/nvim-cmp'
    -- vsnip
    use 'hrsh7th/cmp-vsnip'    -- { name = 'vsnip' }
    use 'hrsh7th/vim-vsnip'
    use 'rafamadriz/friendly-snippets'
    -- lspkind
    use 'onsails/lspkind-nvim'
end)

-- gruvbox nord zephyr-nvim 等主题插件配置
vim.api.nvim_command('set background=dark') -- 设置背景色,调用vim设置的方式
vim.api.nvim_command('colorscheme zephyr') -- 设置主题,调用vim设置的方式

-- treesitter 语法高亮配置
require 'nvim-treesitter.configs'.setup {
    -- 安装 language parser :TSInstallInfo 命令查看支持的语言
    ensure_installed = { "lua", "c", "cpp", "python", "make" },
    -- 启动代码高亮功能
    highlight = { enable = true, additional_vim_regex_highlighting = false },
    -- 启动增量选择
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<CR>',
            node_incremental = '<CR>',
            node_decremental = '<BS>',
            scope_incremental = '<TAB>',
        }
    },
    -- 启用基于Treesitter的代码格式化(=). 实验功能
    indent = { enable = true }
}

-- nvim-tree 配置,  nvim-tree 可执行常见文件操作
-- o 打开关闭文件夹, a 创建文件, r 重命名,
-- x 剪切, c 拷贝, p 粘贴, d 删除
require 'nvim-tree'.setup {
    -- 不显示git状态图标
    git = { enable = false }
}

-- bufferline 配置 bufferline 可以展示顶部tab,标号,跳转,关闭等
vim.opt.termguicolors = true
require('bufferline').setup {
    options = {
        diagnostics = 'nvim_lsp', -- 使用nvim内置lsp
        show_buffer_icons = false, -- 禁用缓冲区的文件类型图标
        show_buffer_close_icons = true, -- 禁用缓冲区的关闭图标
        numbers = 'buffer_id', -- 显示缓冲区文件编号
        max_name_length = 18, -- 最大显示tab的字节数
        tab_size = 5, -- table最小宽度,给小了无影响,给大了浪费空间
        offsets = { { -- 左侧让出nvim-tree的位置
            filetype = 'NvimTree',
            text = 'File Explorer',
            highlight = 'Directory',
            text_align = 'left'
        } }
    }
}

-- lsp lspconfig
local lsp_installer = require 'nvim-lsp-installer'
local lsp_settings = {
    Lua = {
        runtime = {
            -- 告诉语言服务器你正在使用的lua版本,neovim下一般是LuaJIT
            version = 'LuaJiT',
            path = vim.split(package.path, ';')
        },
        diagnostics = { globals = { 'vim' } }, -- 让语言服务器识别vim全局
        workspace = { library = vim.api.nvim_get_runtime_file('', treu) }, -- lsp知道nvim运行时文件
        telemetry = { enable = false }, -- 不发送包含随机但唯一标识符的遥测数据
    }
}
local lsp_servers = { sumneko_lua = lsp_settings }
-- 自动安装 languageServers
for name, _ in pairs(lsp_servers) do
    local server_is_found, server = lsp_installer.get_server(name)
    if server_is_found then
        if not server:is_installed() then
            print('Installing lsp ' .. name)
            server:install()
        end
    end
end
lsp_installer.on_server_ready(function(server)
    local opts = lsp_servers[server.name]
    if opts then
        opts.on_attach = function(_, bufnr)
            local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
            -- 绑定快捷键
            Lsp_keybind_map(buf_set_keymap)
        end
        opts.flags = { debounce_text_changes = 150 }
        server:setup(opts)
    end
end)
-- nvim-cmp 自动补全配置
local lspkind = require('lspkind')
local cmp = require'cmp'
cmp.setup{
    -- 指定snippet 引擎
    snippet = {
        expand = function(args)
            -- for 'vsnip' users.
            vim.fn['vsnip#anonymous'](args.body)
            -- For `luasnip` users.
            -- require('luasnip').lsp_expand(args.body)
            -- For `ultisnips` users.
            -- vim.fn["UltiSnips#Anon"](args.body)
            -- For `snippy` users.
            -- require'snippy'.expand_snippet(args.body)
        end
    },
    -- 来源
    sources = cmp.config.sources({
        {name = 'nvim_lsp'},
        -- for vsnip users.
        {name = 'vsnip'},
        -- For luasnip users.
        -- { name = 'luasnip' },
        --For ultisnips users.
        -- { name = 'ultisnips' },
        -- -- For snippy users.
        -- { name = 'snippy' },
    },{{name = 'buffer'},
            {name = 'path'}
        }),
    -- 快捷键
    mapping = Lsp_cmp(cmp),
    -- 使用lspkind-nvim显示类型图标
    formatting = {
        format = lspkind.cmp_format({
            with_text = true,   -- 不显示图标旁边的文本
            maxwidth = 50,  -- 防止弹出窗口显示超过提供的字符(例如，50 不会显示超过 50 个字符)
            before = function(entry, vim_item)
                -- Source 显示提示来源
                vim_item.menu = '['..string.upper(entry.source.name)..']'
                return vim_item
            end
        })
    },
}
-- 对'/'使用缓冲区来源
cmp.setup.cmdline('/', {sources = {{name = 'buffer'}}})
-- use cmdline & path source for ':'
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        {name = 'path'}},
        {{name = 'cmdline'}
        })
})

