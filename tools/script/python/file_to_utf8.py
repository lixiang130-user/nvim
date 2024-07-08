#!/usr/bin/python3
import chardet
import io
import os

import chardet
import io

def detect_encoding(file_path):
    with open(file_path, 'rb') as f:
        raw_data = f.read()
    result = chardet.detect(raw_data)
    encoding = result['encoding']
    return encoding

def convert_to_utf8(input_file_path, output_file_path):
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
    
    # Write the text to a new file with UTF-8 encoding
    with io.open(output_file_path, 'w', encoding='utf8') as f:
        f.write(text)

if __name__ == "__main__":
    fd = os.popen('find . -type f -regex ".*\.\(c\|h\|cpp\)"')
    while True:
        data = fd.readline()
        if not data:
            break
        file_name = data.split('\n')[0]
        print(f'开始utf8转码: to {file_name}', end='\n')
        convert_to_utf8(file_name, file_name)
        print(f'完成')


