#!/bin/expect
# 设置超时时间
set timeout 500

# 获取所有传入参数，拼接为命令行参数
set args [lrange $argv 0 end]

# 启动 nvim 并传入参数
eval spawn nvim_code $args

# 等待一会，输入命令
expect ".*"
#打开两个默认的终端
#send ":sp\r"
#send ":terminal\r"
#send ":vsp\r"
#send ":terminal\r"
#send "6w-\r"
#send "11w,\r"
##在linux下面的组合键实际就是ASCII,看看任意键值:showkey -a; ctrl+h 是:0010
#send "\013\r"

# 保持交互状态
interact

