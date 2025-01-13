-- init
require('base')
require('keymaps')
require('plugins')
require('functions')

-- 在 Neovim 启动时执行某个函数
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        -- 模拟按下 wm
        vim.cmd('NvimTreeToggle')
        -- 使用 feedkeys 来模拟按下 Ctrl+l
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-w>l', true, true, true), 'n', false)
        -- 打印信息
        --print("xxx")
    end
})
