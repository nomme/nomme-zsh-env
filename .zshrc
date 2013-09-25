##!/bin/zsh
source $HOME/.zsh/colors

alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias rm='rm -i'
alias l='ls -hl --color=auto'
alias gs='git status'

bindkey "^W" "vi-backward-kill-word"

#completion
autoload -U compinit
compinit

# prompt
autoload -U promptinit
promptinit

export PAGER=less
export HISTSIZE=2000
export SAVEHIST=20000
export HISTFILE=~/.zhistory
setopt extended_history
setopt inc_append_history
setopt hist_ignore_space
setopt hist_ignore_dups

if [ -d "$HOME/local/bin" ];
then
  export PATH="$HOME/local/bin:$PATH"
fi
if [ -d "$HOME/local/lib" ];
then
  export LD_LIBRARY_PATH="$HOME/local/lib:$LD_LIBRARY_PATH"
fi

export RPROMPT="%F${fg_green}%~%f"

# Git
source $HOME/.zsh/completion/git
GIT_PS1_SHOWUPSTREAM=auto
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_DESCRIBE_STYLE=contains
GIT_PS1_SHOWCOLORHINTS=true
function precmd()
{
  if [ "root" = "$USER" ];
  then
    export PROMPT="%B%F${fg_red}%m%k ${RED}$(__git_ps1 '[%s]')${fg_blue} %# %b%f%k"
  else
    export PROMPT="%B%F${prompt_color}%n@%m%k%B%F ${RED}$(__git_ps1 '[%s]')${fg_blue} %# %b%f%k"
  fi

  xrp="`extended_rprompt 2> /dev/null`"
  if [ 0 -eq $? ];
  then
    export RPROMPT="%F${fg_green}%~${xrp}%f"
  fi

}

HOST=`hostname`
if [[ "rebound" == $HOST ]];
then
  source ~/.zsh/profiles/zsh.rebound 2> /dev/null
elif [[ "asylum" == $HOST ]];
then
  source ~/.zsh/profiles/zsh.asylum 2> /dev/null
elif [[ "htpc" == $HOST ]];
then
  source ~/.zsh/profiles/zsh.htpc 2> /dev/null
elif [[ "gbguxs10" == $HOST ]];
then
  source ~/.zsh/profiles/zsh.gbguxs10 2> /dev/null
elif [[ "campgrounds" == $HOST ]];
then
  source ~/.zsh/profiles/zsh.campgrounds 2> /dev/null
fi
