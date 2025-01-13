#!/bin/expect
spawn nvim
send "wm\r"
#在linux下面的组合键实际就是ASCII,看看任意键值:showkey -a; ctrl+l 是:0014
send "\014\r"
interact
