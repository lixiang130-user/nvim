-- init
require('base')
require('keymaps')
require('plugins')
require('functions')

-- 在 Neovim 启动时执行某个函数
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        -- local args = vim.fn.argv()  -- 获取所有命令行参数
        -- local last_arg = args[#args]  -- 获取最后一个参数

        -- 获取进程名称
        local prog_name = vim.loop.fs_realpath("/proc/self/exe")
        -- print(prog_name)

        if string.find(prog_name, "nvim_code") then
            -- 执行 NvimTreeToggle 命令
            vim.cmd('NvimTreeToggle')
            -- 使用 feedkeys 来模拟按下 <Ctrl+w>l
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-w>l', true, true, true), 'n', false)
        end
    end
})

