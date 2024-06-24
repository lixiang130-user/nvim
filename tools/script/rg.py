#!/usr/bin/python3
import os
import sys

if len(sys.argv) == 2 and sys.argv[1] == "user_replace":
    if not os.path.exists('/usr/bin/rg_real'):
        os.system('sudo mv /usr/bin/rg /usr/bin/rg_real')
    ret = os.system('sudo cp ./rg.py /usr/bin/rg')
    print("成功替换ripgrep执行文件:", ret)
    exit(0)
if len(sys.argv) == 2 and sys.argv[1] == "user_recover":
    if not os.path.exists('/usr/bin/rg_real'):
        exit(0)
    os.system('sudo mv /usr/bin/rg_real /usr/bin/rg ')
    exit(0)

#忽略特定文件*.d (!filename包含的话去掉叹号),不尊重.gitignore
cmd = 'rg_real -g="!*.d" --no-ignore '
#cmd = "rg_real "
for i in sys.argv[1:-1]:
    cmd = cmd + " " + i
cmd = cmd + ' "' + sys.argv[-1] + '"'
#print(cmd)
os.system(f"echo {cmd} >> /tmp/rg_tmp.log")
os.system(cmd)
