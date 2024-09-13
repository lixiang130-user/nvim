#!/bin/bash

# 检查传递的参数数量是否正确
if [ "$#" -ne 2 ]; then
    echo "Error: Exactly two arguments are required." >&2
    exit 1
fi

# 提取文件路径并转换为 Windows 路径格式
file1=$(wslpath -w "$1")
file2=$(wslpath -w "$2")

# 函数：检查是否有 Beyond Compare 实例在运行，并关闭它
close_bcompare() {
    local process_id
    process_id=$(cmd.exe /c tasklist | grep 'BCompare.exe' | awk '{print $2}')

    if [ -n "$process_id" ]; then
        echo "Closing existing Beyond Compare instance (PID: $process_id)..."
        cmd.exe /c taskkill /PID "$process_id" /F
        # 等待进程完全关闭
        sleep 0.01
    else
        echo "No Beyond Compare instance running."
    fi
}

# 关闭现有的 Beyond Compare 实例（如果有）
close_bcompare

# 使用双引号确保文件路径中的空格不会导致错误
"/mnt/d/Program Files/BCompare/BCompare.exe" "$file1" "$file2"

