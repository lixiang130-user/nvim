#!/bin/expect
set timeout 500
spawn nvim
send ":sp\r"
send ":terminal\r"
send "cio\r"
send ":sp\r"
send ":terminal\r"
send "10w=\r"
interact
