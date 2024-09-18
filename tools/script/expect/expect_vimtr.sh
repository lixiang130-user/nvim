#!/bin/expect
set timeout 500
spawn nvim
send ":sp\r"
send ":terminal\r"
send "cio\r"
send ":vsp\r"
send ":terminal\r"
send ":sp\r"
send ":terminal\r"
send "15w.\r"
send "5w=\r"
interact
