require('keymaps')


-- html格式化,使用ubuntu安装的工具prettier
function Format_with_prettier()
    local file = vim.fn.expand('%')
    local cmd = string.format('prettier --write --tab-width 4 --use-tabs false %s', file)
    vim.fn.system(cmd)
    vim.cmd('e')  -- Reload the file to apply changes
end

-- 翻译插件使用的函数
-- 检测是否为中文字符的函数
local function is_chinese(text)
    -- 匹配中文字符的十六进制范围
    return string.match(text, "[\xE4-\xE9][\x80-\xBF][\x80-\xBF]") ~= nil
end

-- 自动识别并设置翻译方向，并根据模式执行不同的行为
function Auto_translate(mode)
    -- 获取当前选择的文本
    local text = vim.fn.getreg("v")  -- 获取当前视觉模式选择的内容
    if text == "" then
        text = vim.fn.expand("<cword>")  -- 没有选择内容则获取光标下的单词
    end

    -- 判断内容是否包含中文字符并设置翻译方向
    if is_chinese(text) then
        vim.g.translator_source_lang = 'zh-cn'
        vim.g.translator_target_lang = 'en-us'
    else
        vim.g.translator_source_lang = 'en-us'
        vim.g.translator_target_lang = 'zh-cn'
    end

    -- 根据模式决定是否执行命令
    if mode == 'w' then
        vim.cmd("TranslateW", 'n', true)  -- 执行命令
    elseif mode == 't' then
        vim.cmd("Translate", 'n', true)  -- 执行命令
    elseif mode == 'r' then
        vim.cmd("TranslateR", 'n', true)  -- 执行命令
    elseif mode == 'x' then
        vim.api.nvim_feedkeys(":TranslateX ", 'n', false)  -- 留空等待用户输入文本
    else
        vim.cmd("TranslateW", 'n', true)  -- 执行命令
    end
end


--cc指令 若当前窗口是/bin/bash直接退出,否则只是关闭窗口
function CloseWindow()
    local win_count = vim.fn.winnr('$')  -- 获取窗口总数
    -- 检查当前窗口是否是最后一个
    if win_count == 1 then
        print("最后一个窗口无法关闭")
        return  -- 如果是最后一个窗口，就不执行任何操作
    end

    local buf_name = vim.api.nvim_buf_get_name(0)  -- 获取当前缓冲区的名称
    print("关闭终端:" .. buf_name)
    if string.match(buf_name, "term://") then
        vim.cmd('bwipeout!')
    else
        vim.cmd('wincmd c')
    end
end


--cb指令 关闭所有"/bin/bash 的窗口
function CloseBuffersWithBash()
    -- Get a list of all buffers
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        -- Check if the buffer is loaded and the name contains 'bash'
        if vim.api.nvim_buf_is_loaded(buf) then
            local bufname = vim.api.nvim_buf_get_name(buf)
            if bufname:match("/bin/bash") then
                -- Delete the buffer
                vim.api.nvim_buf_delete(buf, { force = true })
            end
        end
    end
end

--co指令 关闭名称中包含"/bin/bash"的窗口和缓冲区 并 关闭其他窗口但保留缓冲区
function CloseBashBuffersAndCloseOthers()
    -- Close buffers with 'bash' in their name
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) then
            local bufname = vim.api.nvim_buf_get_name(buf)
            if bufname:match("/bin/bash") then
                vim.api.nvim_buf_delete(buf, { force = true })
            end
        end
    end
    -- Close all other windows
    vim.cmd('only')
end


--":b "->"Bgoto "指令 将Bgoto后跟非数字是替换回 ": b xxx", " b",空格b,避免了b循环替换成Bgoto
vim.api.nvim_create_autocmd("CmdlineChanged", {
    group = "Replace_Bgoto_With_b_Group",
    pattern = ":",
    callback = function()
        local cmdline = vim.fn.getcmdline()

        -- 检查命令是否以 'Bgoto' 开头，且后续字符为非数字和非空格
        local Bgoto_match = cmdline:match("^Bgoto%s*(.*)")
        if Bgoto_match and Bgoto_match:match("^[^%d%s]") then
            -- 构建新命令，将 Bgoto 替换为 " b "
            local new_cmd = " b " .. Bgoto_match
            -- 使用 `vim.fn.setcmdline` 来更新命令行内容
            vim.fn.setcmdline(new_cmd)
        end
    end
})


--"Bgoto 数字转换"指令 创建一个函数用于根据 `bufferline` 的序号跳转
function BufferlineGoToBuffer(buf_arg)
    local buffers = vim.fn.getbufinfo({ buflisted = 1 })
    -- 如果参数是数字，跳转到指定的缓冲区索引
    local buf_index = tonumber(buf_arg)
    if buf_index then
        if buf_index < 1 or buf_index > #buffers then
            print("Buffer index out of range")
            return
        end
        local target_bufnr = buffers[buf_index].bufnr
        vim.api.nvim_set_current_buf(target_bufnr)
    else
        -- 如果参数是非数字，直接执行内置的 :b 跳转
        vim.api.nvim_command('b ' .. buf_arg)
    end
end
