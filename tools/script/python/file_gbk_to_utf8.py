#!/usr/bin/env python3
import io
import sys
import os

def convert_to_utf8(file_path):
    content = None
    # 尝试使用 gb2312 正常解码
    try:
        with io.open(file_path, 'r', encoding='gb2312') as f:
            content = f.read()
    except UnicodeDecodeError as e:
        print(f"文件 {file_path} 使用 gb2312 解码失败，错误信息：{e}")
        print("尝试使用 gbk 解码...")
        try:
            with io.open(file_path, 'r', encoding='gbk') as f:
                content = f.read()
        except UnicodeDecodeError as e2:
            print(f"文件 {file_path} 使用 gbk 解码也失败，错误信息：{e2}")
            # 作为备用方案，使用 gbk 并忽略错误
            print("尝试使用 gbk 解码并忽略错误...")
            with io.open(file_path, 'r', encoding='gbk', errors='ignore') as f:
                content = f.read()
            print("注意：部分字符可能无法正确转换！")
    
    if content is not None:
        # 转换为无 BOM 的 UTF-8 后覆盖原文件
        with io.open(file_path, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"转换完成: {file_path}")
    else:
        print(f"无法解码文件 {file_path}，请检查文件编码或文件是否损坏。")

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("用法: {} 文件1 文件2 ...".format(sys.argv[0]))
        sys.exit(1)
    
    for file_path in sys.argv[1:]:
        if os.path.isfile(file_path):
            convert_to_utf8(file_path)
        else:
            print(f"文件不存在或不是一个有效文件: {file_path}")

