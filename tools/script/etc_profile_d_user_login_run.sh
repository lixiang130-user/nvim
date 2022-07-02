#!/bin/bash
#启动fastgithub代理
export http_proxy="http://127.0.0.1:38457"
export https_proxy="http://127.0.0.1:38457"
~/.user_tools/user_tools_start.sh &

PATH=$PATH:~/.user_tools/nvim-linux64/bin
