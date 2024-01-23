#!/bin/expect
#expect_telnet 使用telnet连接设备,自动输入账号密码
set ip [lindex $argv 0]
#设置等待超时时间
set timeout 500
spawn telnet 192.168.222.$ip
expect "login:"
send "root\r"
expect "Password:"
send "comtom@admin\r"
#send "ulimit -c 40960\r"   #unlimited 不限制大小
send "ulimit -c unlimited\r"
#send "echo '/app/comtom/log/coredump_%e' > /proc/sys/kernel/core_pattern"
send "cd /app/comtom/bin/\r"
interact
