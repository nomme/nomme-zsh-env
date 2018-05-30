#export prompt_color="$fg_brown"
export TERM=dtterm

export USE_CCACHE="Y"

export FZF_DEFAULT_OPTS="--bind=ctrl-j:accept"
export FZF_DEFAULT_COMMAND='ag -g "" --ignore "*Test.[ch]pp" --ignore "*\.$"'

if [ -d "$HOME/local/tmuxifier/bin" ];
then
  export PATH="$HOME/local/tmuxifier/bin:$PATH"
  tmuxifier init - > /dev/null
  source $HOME/local/tmuxifier/completion/tmuxifier.zsh
  alias tl='tmuxifier load-window'
fi

eval `dircolors -b`
export ZLS_COLORS=$LS_COLORS
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==02=01}:${(s.:.)LS_COLORS}")'

export CURRENTPROJ="SEM"
tmuxsession="$(tmux list-panes -F "#S")"
if [[ $tmuxsession == ihu* ]]
then
  export CURRENTPROJ="IHU"
elif [[ $tmuxsession == sem* ]]
then
  export CURRENTPROJ="SEM"
fi

source $HOME/.${CURRENTPROJ}_params

export PATH="$AOSP_HOME/out/host/linux-x86/bin:$PATH"

source $HOME/local/profile
export CCACHE_BASEDIR="$AOSP_HOME"

##########
# watchman
##########

if [ -d $HOME/local/watchman/lib ]
then
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/local/watchman/lib"
fi

if [ -d $HOME/local/watchman/bin ]
then
    export PATH="$PATH:$HOME/local/watchman/bin"
fi

##########
# git
##########

if [ -d $HOME/local/git/lib ]
then
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/local/git/lib"
fi

if [ -d $HOME/local/git/bin ]
then
    export PATH="$PATH:$HOME/local/git/bin"
fi


##################
# Functions
##################
extended_rprompt()
{
  if [ -n "$OECORE_SDK_VERSION" ]
  then
      echo " ${BLUE}[${RED}$OECORE_SDK_VERSION${BLUE}]${NORM}"
  else
      set -x
      source $HOME/.${CURRENTPROJ}_params
      set +x
      echo " ${BLUE}[${RED}$CURRENTPROJ${BLUE} / ${RED}$USED_DISPLAY_DEVICE${BLUE}]${NORM}"
  fi
}

man()
{
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
      man "$@"
}

##################
# End Functions
##################
alias myps='ps -leaf | grep jhogklin'
alias rmorig='rm **/*.orig'

alias ihu='export CURRENTPROJ=IHU && source $HOME/.${CURRENTPROJ}_params'
alias sem='export CURRENTPROJ=SEM && source $HOME/.${CURRENTPROJ}_params'

# navigation
alias h='cd $AOSP_HOME'
alias d='cd $AOSP_HOME/device/delphi'
alias a='cd $AOSP_HOME/device/aptiv'
alias c='cd $AOSP_HOME/vendor/aptiv/components'
alias p='cd $PRODUCT_HOME'

# tmux alias
alias ihu1='tmuxifier load-session ihu1'
alias ihu2='tmuxifier load-session ihu2'
alias sem1='tmuxifier load-session sem1'
alias sem2='tmuxifier load-session sem2'
