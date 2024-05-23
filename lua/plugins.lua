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
    use { 'neovim/nvim-lspconfig'} -- 'williamboman/nvim-lsp-installer' }
    use { 'williamboman/mason.nvim' }
    -- :mason update更新注册表内容, 手动更新语言解析服务器 MasonInstall <package> ... 安装/重新安装提供的软件包
    use {'williamboman/mason.nvim', run = ':MasonUpdate'}
    use { 'williamboman/mason-lspconfig.nvim' }
    -- lsp 自动补全功能
    use 'hrsh7th/nvim-cmp'  -- 自动补全插件本身
    use 'onsails/lspkind-nvim'  -- 美化自动补全窗口的插件
    use 'hrsh7th/cmp-nvim-lsp' -- 可从内置lsp提供的补全
    use 'hrsh7th/cmp-buffer'    -- 从缓冲区补全
    use 'hrsh7th/cmp-path'  -- 从路径补全
    use {'hrsh7th/cmp-vsnip', -- 自动补全代码段,生成代码块
        requires = {'hrsh7th/vim-vsnip','rafamadriz/friendly-snippets'}}
    -- vista.vim 插件,显示大纲,函数变量
    use 'liuchengxu/vista.vim'
    -- telescope 强大的文件搜索 预览 等
    -- use {'nvim-telescope/telescope.nvim', requires = {'nvim-lua/plenary.nvim'}}
    use {'nvim-telescope/telescope-file-browser.nvim', requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }}
    -- vim-translatoruse 翻译插件
    use 'voldikss/vim-translator'
    -- lualine 状态栏插件
    use {'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons', opt = true }}
    -- interestingwords高量插件
    use 'lfv89/vim-interestingwords'
    -- leap 快速跳转搜索
    use {'ggandor/leap.nvim', requires = {'tpope/vim-repeat',}}
end)

--leap 使用s/S char1 char2 即可跳转到对应位置, 多个字符是,会展示字符,选择字母跳转过去
--require('leap').add_default_mappings()    --默认使用s/S

-- gruvbox nord zephyr-nvim 等主题插件配置
vim.api.nvim_command('set background=dark') -- 设置背景色,调用vim设置的方式
vim.api.nvim_command('colorscheme zephyr') -- 设置主题,调用vim设置的方式

-- treesitter 语法高亮配置
require 'nvim-treesitter.configs'.setup {
    -- 安装 language parser :TSInstallInfo 命令查看支持的语言
    ensure_installed = { 'lua', 'c', 'cpp', 'python', 'make', 'json'},
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
    -- 会导致python插入模式下输入冒号缩进改变,关闭这个实验功能
    -- indent = { enable = true }  -- 启用基于Treesitter的代码格式化(=). 实验功能
}

-- nvim-tree 配置,  nvim-tree 可执行常见文件操作
-- o 打开关闭文件夹, a 创建文件, r 重命名,
-- x 剪切, c 拷贝, p 粘贴, d 删除
-- 在 init.lua 的最开始禁用 netrw
local function nvim_tree_on_attach(bufnr)
    require('keymaps').nvim_tree(bufnr)
end
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- 设置 termguicolors 以启用高亮组
vim.opt.termguicolors = true
require('nvim-tree').setup({
    -- 不显示git状态图标
    git = { enable = false },
    view = {width = 23,preserve_window_proportions = true,},    --不调整文件窗口大小
    filters = { dotfiles = false,}, --不过滤.文件(隐藏文件)
    on_attach = nvim_tree_on_attach,    -- 按键映射
    actions = {open_file = {resize_window = false,}}    --不调整nvim-tree窗口大小
})

-- bufferline 配置 bufferline 可以展示顶部tab,标号,跳转,关闭等
vim.opt.termguicolors = true
require('bufferline').setup {
    options = {
        diagnostics = 'nvim_lsp', -- 使用nvim内置lsp
        show_buffer_icons = false, -- 禁用缓冲区的文件类型图标
        show_buffer_close_icons = false, -- 禁用缓冲区的关闭图标
        numbers = 'buffer_id', -- 显示缓冲区文件编号
        max_name_length = 18, -- 最大显示tab的字节数
        tab_size = 5, -- table最小宽度,给小了无影响,给大了浪费空间
        offsets = { { -- 左侧让出nvim-tree的位置
            filetype = 'NvimTree',
            text = 'File Explorer',
            highlight = 'Directory',
            text_align = 'left'
        } },
        separator_style =  'slant', -- 倾斜的标签
        indicator = {style = 'underline'},    -- 展示下划线
    }
}

-- lspconfig 配置, servers 参考对应语言
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.txt
-- local servers = {
--     sumneko_lua = { Lua = {
--         runtime = {version = 'LuaJIT'},
--         diagnostics = {globals = { 'vim' }},
--         workspace = {library = vim.api.nvim_get_runtime_file('', true),},
--         telemetry = {enable = false,},
--     }},
--     -- 根据不同的语言使用不同的配置
--     clangd = {},
--     pyright = {},
--     pylsp = { settings = {pylsp = {plugins = {pycodestyle = {
--         maxLineLength = 300,
--         ignore = {'W391', 'E401', 'E265', 'E262', 'E128', 'E231', 'E402',
--         'E123', 'E126', 'E225', 'E701', 'E261', 'E226', 'W291', 'W293',
--         'E251', 'E127', 'E227', 'E241', 'W503', 'E124', 'E201'
--     }}}}}},
--     jsonls = {},
-- }
-- for name, _ in pairs(servers) do
--     local server_is_found, server = require 'nvim-lsp-installer'.get_server(name)
--     if server_is_found then
--         if not server:is_installed() then
--             print('Installing ' .. name)
--             server:install()
--         end
--     end
-- end
-- -- 应该是判断安装完成的回调函数
-- local lsp_flags = { debounce_text_changes = 150 } --nvim0.7+默认配置
-- require 'nvim-lsp-installer'.on_server_ready(function(server)
--     local opts = servers[server.name]
--     if opts then
--         opts.on_attach = function()
--             require('keymaps').lsp_map()
--         end
--         opts.flags = lsp_flags
--         server:setup(opts)
--     end
-- end)

-- mason 语法解析器
require'mason'.setup({
    ui = {
        icons = {
            package_installed = '√',
            package_pending = '→',
            package_uninstalled = '×',
        },
    },
})
-- 按键映射
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  require('keymaps').lsp_map()
end
-- 支持解析的语法, 确保安装,根据需要填写, 可以改成循环的方式,暂时不实现了
require'mason-lspconfig'.setup({
    ensure_installed = {
        'lua_ls',
        'pyright',
        'clangd',
        'bashls',
        'pylsp',
    },
})
require'lspconfig'['lua_ls'].setup{ on_attach =  on_attach}
require'lspconfig'['clangd'].setup{ on_attach =  on_attach}
require'lspconfig'['bashls'].setup{ on_attach =  on_attach}
require'lspconfig'['pyright'].setup{ on_attach =  on_attach}
require'lspconfig'['pylsp'].setup{
    on_attach =  on_attach,
    settings = { pylsp = { plugins = { pycodestyle = {
        maxLineLength = 300,
        ignore = {
            'W391', 'E401', 'E265', 'E262', 'E128', 'E231', 'E402',
            'E123', 'E126', 'E225', 'E701', 'E261', 'E226', 'W291',
            'W293', 'E251', 'E127', 'E227', 'E241', 'W503', 'E124',
            'E201', 'E221', 'W504', 'W605', 'E125'
    }}}}},
}

-- lsp 自动补全功能
local cmp = require'cmp'
cmp.setup {
    -- 必须指定代码段引擎 -- For `vsnip` users. 就是vim-vsnip插件
    snippet = {expand = function(args) vim.fn['vsnip#anonymous'](args.body)end},
    sources = cmp.config.sources({
            {name='vsnip'},
            {name='nvim_lsp'},
        },{
            {name = 'buffer'},
            {name = 'path'}
        }),-- 来源
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
if os.getenv('google_translator_vim') ~= nil then
    vim.g.translator_default_engines = {'bing', 'haici', 'google'}
elseif os.getenv('https_proxy') ~= nil then    -- 没有使用windows的全局代理
    vim.g.translator_default_engines = {'bing', 'haici', 'google'}
else
    vim.g.translator_default_engines = {'bing', 'haici'}
end
vim.g.translator_window_max_width = 0.5     -- 设置悬浮窗大小
-- vim.g.translator_window_max_height = 0.6

-- lualine配置
--[[
可选组件
branch（吉特分支）
buffers（显示当前可用的缓冲区）
diagnostics（诊断计数来自您的首选来源）
diff（git 差异状态）
encoding（文件编码）
fileformat（文件格式）
filename
filesize
filetype
hostname
location（文件中的位置行：列格式）
mode（可视化模式）
progress（文件中的进度百分比）
searchcount（HL搜索处于活动状态时的搜索匹配数）
selectioncount（所选字符数或行数）
tabs（显示当前可用的选项卡）
windows（显示当前可用的窗口）
]]--
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    -- component_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ''},
    component_separators = '|',
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    --lualine_a = {'mode'},
    lualine_a = {},
    --lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_b = {{'filename', path=1}, 'diff', 'diagnostics'},
    --lualine_c = {'filename'},
    lualine_c = {},
    lualine_x = {'encoding', {'fileformat', icons_enabled=false}, 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

-- 望远镜配置
require('telescope').setup({
    defaults = {
        file_ignore_patterns = {
            '.git', --忽略特定的文件/文件夹
            '.cache',
        },
    },
})
