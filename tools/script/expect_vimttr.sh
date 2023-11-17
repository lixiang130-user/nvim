#!/bin/expect
set timeout 500
spawn nvim
send "tt\r"
send "co\r"
send "tv\r"
send "ts\r"
send "15w.\r"
send "5w=\r"
interact
