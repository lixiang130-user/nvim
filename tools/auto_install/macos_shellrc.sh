
function proxy_on()
{
    export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
    export http_proxy="http://127.0.0.1:7890"
    export https_proxy=$http_proxy
    #export all_proxy=socks5://127.0.0.1:7890 # or this line
    echo -e "已开启代理"
}

function proxy_off()
{
    unset http_proxy
    unset https_proxy
    echo -e "已关闭代理"
}

alias vi='nvim'
alias vim='nvim'
alias ll='ls -al'
alias rm='trash'
#export PATH=$PATH:/opt/homebrew/bin
