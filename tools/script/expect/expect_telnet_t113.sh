#!/bin/expect
#expect_telnet 使用telnet连接设备,自动输入账号密码
set ip [lindex $argv 0]
#设置等待超时时间
set timeout 1
spawn telnet $ip
expect "login:"
send "root\r"
send "ulimit -c unlimited\r"
send "export LD_LIBRARY_PATH=/app/comtom/lib:\$LD_LIBRARY_PATH \r"
send "echo '/app/comtom/log/coredump_%e' > /proc/sys/kernel/core_pattern \r"
send "cd /app/comtom/bin/\r"
#send "killall comtom_app_start.sh 2>>/dev/null\r"
send "\r\r"
interact
