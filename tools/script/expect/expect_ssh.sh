#!/bin/expect
#expect_ssh 使用ssh连接服务器,自动输入账号密码
set addr [lindex $argv 0]
#设置等待超时时间
set timeout 1
spawn ssh $addr
expect "assword:"
send "123456\r"
interact
