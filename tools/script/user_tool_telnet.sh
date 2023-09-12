#!/bin/expect
#user_tool_telnet 使用telnet连接设备,自动输入账号密码
set ip [lindex $argv 0]
set timeout 500
spawn telnet 192.168.8.$ip
expect "login:"
send "root\r"
expect "Password:"
send "comtom@admin\r"
interact
