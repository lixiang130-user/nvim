#!/bin/bash

# 检查传递的参数数量是否正确
if [ "$#" -ne 2 ]; then
    echo "Error: Exactly two arguments are required." >&2
    exit 1
fi

# 提取文件路径并转换为 Windows 路径格式
file1=$(wslpath -w "$1")
file2=$(wslpath -w "$2")

# 使用双引号确保文件路径中的空格不会导致错误
"/mnt/d/Program Files/BCompare/BCompare.exe" "$file1" "$file2"
