export prompt_color="$fg_brown"
export TERM=dtterm

export FZF_DEFAULT_OPTS="--bind=ctrl-j:accept"
export FZF_DEFAULT_COMMAND='ag -g "" --ignore "*Test.[ch]pp" --ignore "*\.$"'

export USE_CCACHE="Y"

if [ -d "$HOME/local/tmuxifier/bin" ];
then
  export PATH="$HOME/local/tmuxifier/bin:$PATH"
  tmuxifier init - > /dev/null
  source $HOME/local/tmuxifier/completion/tmuxifier.zsh
  alias tl='tmuxifier load-window'
fi

#if [ -d "$HOME/local/dltviewer/usr" ];
#then
#  export PATH="$PATH:$HOME/local/dltviewer/usr/bin"
#  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/local/dltviewer/usr/lib
#fi

if [ -d "$HOME/local/android" ];
then
  export PATH="$HOME/local/android:$PATH"
fi

# autocompletion colors
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
#export PATH="$AOSP_HOME/out/host/linux-x86/bin:$PATH"

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

get_git()
{
    if [ $# -ne 1 ]
    then
        echo "get_git <repo name>" 2>/dev/null
        exit 1
    fi

    git clone ssh://njw5c6@10.236.95.27:29418/$1 && scp -p -P 29418 njw5c6@10.236.95.27:hooks/commit-msg $1/.git/hooks/
}

function run_adb_shell()
{
    BUFFER="adb shell $BUFFER"
    zle accept-line
}

zle -N run_adb_shell
bindkey "^K" run_adb_shell

function sme()
{
    bash --rcfile <(echo "\
        source $HOME/.bashrc && \
        pushd $AOSP_HOME && \
        source build/envsetup.sh && \
        lunch $LUNCH_IT && \
        popd")
}

function pushsel()
{
    local readonly selinux_dir="$AOSP_HOME/out/target/product/$PROJ_DEVICE/vendor/etc/selinux"
    [ -d $selinux_dir ] || { echo "error: Directory not found $selinux_dir"; exit 1 }
    b :
    adb remount
    adb push $AOSP_HOME/out/target/product/$PROJ_DEVICE/vendor/etc/selinux /vendor/etc
    adb reboot
}

##################
# End Functions
##################

#alias runctags='ctags -R --exclude="*test*" --exclude="*[Ss]tub*" --exclude="*ctcif*" --exclude="*include*"'
alias myps="ps -leaf | grep $USER"
alias rmorig='rm **/*.orig'

alias ssdk="source $IHU_SOURCE"
alias sutsdk="source $IHU_UT_SOURCE"
alias win='cd /mnt/c/Users/JimmieH'
alias vcm_serial='picocom -b 115200 /dev/ttyUSB'

# navigation
alias h='cd $AOSP_HOME'
alias d='cd $AOSP_HOME/device/delphi/volvoihu'
alias a='cd $AOSP_HOME/device/aptiv'
alias c='cd $AOSP_HOME/vendor/aptiv/components'
alias p='cd $PRODUCT_HOME'
alias mani='cd $AOSP_HOME/.repo/manifests'
alias vm='vim $AOSP_HOME/.repo/manifest.xml'

# tmux alias
alias ihu1='tmuxifier load-session ihu1'
alias ihu2='tmuxifier load-session ihu2'
alias sem1='tmuxifier load-session sem1'
alias sem2='tmuxifier load-session sem2'

# Build AOSP
alias rr='run_remote'
alias m='run_remote m'
alias mm='run_remote mm'
alias mma='run_remote mma'
alias mmm='run_remote mmm'
alias mmma='run_remote mmma'
alias hmm='run_remote hmm'
alias repo='run_remote repo'

alias rmout='run_remote rm -rf out'
alias init_sem='run_remote repo init -u ssh://njw5c6@10.236.95.27:29418/vgtt_p2952_manifests -b master -m devel-o.xml --reference=/home/common/mirrors/sem'
alias init_ihu='run_remote repo init -u ssh://njw5c6@10.236.95.27:29418/Android_bsd_manifest -b devel -m IHU_android-O-devel.xml --repo-url=http://10.236.88.232/git/git-repo --no-repo-verify --reference=/home/common/mirrors/ihu'
alias core='ssh core-build-01'
alias aag='ag --ignore out --ignore cts'

alias rb='shutdown_win7 && systemctl reboot'
alias sd='shutdown_win7 && systemctl poweroff'
alias stopflicker='xrandr --output DP1-2 --off && setmonitor.sh'

if [[ -z "$DISPLAY" && $(tty) == /dev/tty1 ]]
then
    startx
fi

