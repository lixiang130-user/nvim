#!/bin/expect
set param1 [lindex $argv 0]
set param2 [lindex $argv 1]
set param3 [lindex $argv 2]
set param4 [lindex $argv 3]
set param5 [lindex $argv 4]
#设置等待超时时间
set timeout 5
spawn /usr/local/comtom_toolchain/mi30x/arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gdb $param1 $param2 $param3 $param4 $param5
#等待gdb可以输入指令
expect "(gdb)"
send "\r"
send "set solib-search-path ./build/image/libs/:/home/user/linux/code_library/ODMTerm/kernel-mi30x/ct_rootfs/lib/\r"
send "\r"
send "bt\r"
interact
