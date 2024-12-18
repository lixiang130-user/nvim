#!/usr/bin/python3
import chardet
import io
import os
import sys

def detect_encoding(file_path):
    with open(file_path, 'rb') as f:
        raw_data = f.read()
    result = chardet.detect(raw_data)
    encoding = result['encoding']
    return encoding

def convert_to_utf8_bom(input_file_path, output_file_path, bom):
    # Detect the original encoding
    original_encoding = detect_encoding(input_file_path)
    
    # Read the file with the detected encoding
    try:
        with io.open(input_file_path, 'r', encoding=original_encoding, errors='ignore') as f:
            text = f.read()
    except UnicodeDecodeError:
        print(f"Failed to decode with detected encoding {original_encoding}. Trying 'gbk'...")
        try:
            with io.open(input_file_path, 'r', encoding='gbk', errors='ignore') as f:
                text = f.read()
        except UnicodeDecodeError:
            print("Failed to decode with 'gbk' encoding. Trying 'latin1'...")
            with io.open(input_file_path, 'r', encoding='latin1', errors='ignore') as f:
                text = f.read()
    
    # Write the text to a new file with UTF-8 BOM encoding
    if bom:
        with io.open(output_file_path, 'w', encoding='utf-8-sig') as f:
            f.write(text)
    else:
        with io.open(output_file_path, 'w', encoding='utf-8') as f:
            f.write(text)


if __name__ == "__main__":
    bom = True if len(sys.argv) < 2 or sys.argv[1].lower() != "nobom" else False
    target_file = sys.argv[2] if len(sys.argv) > 2 else None

    if target_file:
        # 如果指定了文件，则只处理该文件
        if os.path.isfile(target_file):
            print(f'开始转换为 UTF-8 {"BOM" if bom else "无 BOM"} 格式: {target_file}')
            convert_to_utf8_bom(target_file, target_file, bom)
            print(f'完成转换: {target_file}')
        else:
            print(f'指定的文件不存在: {target_file}')
    else:
        # 未指定文件，处理当前目录下的所有符合条件的文件
        fd = os.popen(r'find . -type f -regex ".*\.\(c\|h\|cpp\)"')
        while True:
            data = fd.readline()
            if not data:
                break
            file_name = data.strip()
            print(f'开始转换为 UTF-8 {"BOM" if bom else "无 BOM"} 格式: {file_name}')
            convert_to_utf8_bom(file_name, file_name, bom)
            print(f'完成转换: {file_name}')

