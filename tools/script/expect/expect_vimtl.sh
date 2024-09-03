#!/bin/expect
set timeout 500
spawn nvim
send "tt\r"
send "cio\r"
send "tv\r"
send "15w,\r"
#在linux下面的组合键实际就是ASCII,看看任意键值:showkey -a; ctrl+h 是:0010
send "\010\r"
send "ts\r"
send "5w=\r"
interact
