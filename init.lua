-- init
require('base')
require('keymaps')
require('plugins')
require('functions')

-- 在 Neovim 启动时执行某个函数
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        -- 获取最后一个传递的参数
        local last_arg = vim.fn.argv(vim.fn.argc() - 1)  -- 获取最后一个参数
        -- 如果最后一个参数是 "run_code"，则执行相应操作
        if last_arg == "run_code" then
            -- 执行 NvimTreeToggle 命令
            vim.cmd('NvimTreeToggle')
            -- 使用 feedkeys 来模拟按下 <Ctrl+w>l
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-w>l', true, true, true), 'n', false)
            -- 可以选择打印信息
            -- print("xxx")
        end
    end
})

