#!/bin/expect
set timeout 500
spawn nvim
send "tt\r"
send "co\r"
send "tv\r"
interact
