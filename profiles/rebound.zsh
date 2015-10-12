alias irc='~/apps/tmuxinit.sh'
alias torrent='tmux attach -d -t torrent'
alias prog='tmux attach -d -t prog'

#alias extended_rprompt='echo " ${fg_red}[${fg_blue}$TEST${fg_red}]"'
export prompt_color="${fg_green}"

#zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==02=01}:${(s.:.)LS_COLORS}")'

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib64/llvm
