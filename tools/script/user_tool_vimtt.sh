#!/bin/expect
set timeout 500
spawn nvim
send "tt\r"
send "co\r"
send "tv\r"
send "15w.\r"
interact
