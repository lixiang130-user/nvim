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
    -- lspconfig 提供跳转到定义，查找引用，悬停文档提示等功能
    use { 'neovim/nvim-lspconfig', 'williamboman/nvim-lsp-installer' }
    -- lsp 自动补全功能
    use 'hrsh7th/nvim-cmp'  -- 自动补全插件本身
    use 'hrsh7th/cmp-nvim-lsp' -- 可从内置lsp提供的补全
    use 'hrsh7th/vim-vsnip' -- 一个snippet引擎
    use 'onsails/lspkind-nvim'  -- 美化自动补全窗口的插件
    use 'hrsh7th/cmp-buffer'    -- 从缓冲区补全
    -- vista.vim 插件,显示大纲,函数变量
    use 'liuchengxu/vista.vim'
    -- telescope 强大的文件搜索 预览 等
    use {"nvim-telescope/telescope.nvim", requires = {"nvim-lua/plenary.nvim"}}
    -- vim-translatoruse 翻译插件
    use 'voldikss/vim-translator'
end)

-- gruvbox nord zephyr-nvim 等主题插件配置
vim.api.nvim_command('set background=dark') -- 设置背景色,调用vim设置的方式
vim.api.nvim_command('colorscheme zephyr') -- 设置主题,调用vim设置的方式

-- treesitter 语法高亮配置
require 'nvim-treesitter.configs'.setup {
    -- 安装 language parser :TSInstallInfo 命令查看支持的语言
    ensure_installed = { "lua", "c", "cpp", "python", "make", "json"},
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
    indent = { enable = true }  -- 启用基于Treesitter的代码格式化(=). 实验功能
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

-- lspconfig 配置, servers 参考对应语言
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.txt
local servers = {
    sumneko_lua = { Lua = {
        runtime = {version = 'LuaJIT'},
        diagnostics = {globals = { 'vim' }},
        workspace = {library = vim.api.nvim_get_runtime_file("", true),},
        telemetry = {enable = false,},
    }},
    -- 根据不同的语言使用不同的配置
    clangd = {},
    pyright = {},
    jsonls = {},
}
for name, _ in pairs(servers) do
    local server_is_found, server = require 'nvim-lsp-installer'.get_server(name)
    if server_is_found then
        if not server:is_installed() then
            print("Installing " .. name)
            server:install()
        end
    end
end
-- 应该是判断安装完成的回调函数
local lsp_flags = { debounce_text_changes = 150 } --nvim0.7+默认配置
require 'nvim-lsp-installer'.on_server_ready(function(server)
    local opts = servers[server.name]
    if opts then
        opts.on_attach = function()
            require('keymaps').lsp_map()
        end
        opts.flags = lsp_flags
        server:setup(opts)
    end
end)

-- lsp 自动补全功能
local cmp = require'cmp'
cmp.setup {
    -- 必须指定代码段引擎 -- For `vsnip` users. 就是vim-vsnip插件
    snippet = {expand = function(args) vim.fn["vsnip#anonymous"](args.body)end},
    sources = cmp.config.sources({{name='nvim_lsp'},{name='vsnip'}},{{name = 'buffer'}}),-- 来源
    mapping = require'keymaps'.cmp(cmp),    -- 快捷键配置
    formatting = {format = require'lspkind'.cmp_format({
        with_text = true, -- 不要在图标旁边显示文本
        maxwidth = 50,  -- 放置弹出窗口显示超过设定的字符50
        before = function(entry, vim_item)  --source 显示提供源
            vim_item.menu = '['..string.upper(entry.source.name)..']'
            return vim_item
        end
    })}
}

-- vim-translator 插件
-- haici bing 可用 google超时,如果启用的外部翻墙就是用google翻译
local ret_proxy = os.execute("env | grep all_proxy")
if ret_proxy == 512 then    -- 没有使用windows的全局代理
    vim.g.translator_default_engines = {'bing', 'google'}
else
    vim.g.translator_default_engines = {'bing', 'haici'}
end
vim.g.translator_window_max_width = 0.9     -- 设置悬浮窗大小
vim.g.translator_window_max_height = 0.6
