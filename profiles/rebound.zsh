alias irc='~/local/bin/tmuxinit.sh'
alias torrent='tmux attach -d -t torrent'
alias prog='tmux attach -d -t prog'

export FZF_DEFAULT_OPTS="--bind=ctrl-j:accept"
export FZF_DEFAULT_COMMAND='ag -g "" --ignore "*Test.[ch]pp" --ignore "*\.$"'

#alias extended_rprompt='echo " ${fg_red}[${fg_blue}$TEST${fg_red}]"'
export prompt_color="${fg_green}"

#zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==02=01}:${(s.:.)LS_COLORS}")'

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib64/llvm


#Temp commented because delay when opening shell
#if [ -d "/home/hogklint/.cargo/bin" ]
#then
#  export PATH="$PATH:/home/hogklint/.cargo/bin"
#fi

#if [ -d "$(rustc --print sysroot)/lib/rustlib/src/rust/src" ]
#then
#  export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
#fi
