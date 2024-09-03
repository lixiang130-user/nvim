#!/bin/expect
set timeout 500
spawn nvim
send "tt\r"
send "cio\r"
send "tv\r"
send "ts\r"
send "15w.\r"
send "5w=\r"
interact
