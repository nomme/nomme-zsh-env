export prompt_color="$fg_brown"
export TERM=dtterm
export TERMINFO=/home/jhogklin/.terminfo
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/local/temp/lib:/usr/local/lib:$HOME/local/lib
export BUILDSERVER="gbguxs10"
export BUILDSERVERHOME="/export/home/Users/jhogklin"
#
# autocompletion colors
eval `dircolors -b`
export ZLS_COLORS=$LS_COLORS
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==02=01}:${(s.:.)LS_COLORS}")'

tmuxsession=`tmux list-panes -F "#S"`

export CURRENTPROJ="TCC_ER_CIS_SW"
#export TMUXCOLOR="red"
if [[ $tmuxsession == bv* ]]
then
  export CURRENTPROJ="TCC_ER_BV_SW"
 # export TMUXCOLOR="red"
elif [[ $tmuxsession == kaz* ]]
then
 # export TMUXCOLOR="cyan"
  export CURRENTPROJ="TCC_ER_CIS_SW"
fi

##################
# Functions
##################
extended_rprompt()
{
  echo " ${BLUE}[${RED}$CURRENTPROJ${BLUE}]${NORM}"
}

kaz()
{
  export CURRENTPROJ="TCC_ER_CIS_SW"
}
bv()
{
  export CURRENTPROJ="TCC_ER_BV_SW"
}
gbc()
{
  export CURRENTPROJ="TCC_IND_GBC_SW"
}
gp()
{
  export CURRENTPROJ="TCC_SW"
}

udpsend()
{
  java -cp ~/local/bin udpsend 10.160.154.153 10560 $1
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

gml()
{
  dir=`pwd | sed 's/\/home\/jhogklin/\$HOME\/solhome/'`
  ssh gbguxs21 "source /etc/profile && cd "$dir" && gmake -j8 NO_OPTIMIZATION=Y"
}
##################
# End Functions
##################

alias 10='ssh -X gbguxs10'
alias 21='ssh -X gbguxs21'
alias pavel='ssh pavel Users/jhogklin/init.sh'
alias reboot='systemctl reboot'
#alias shutdown='systemctl shutdown -h now'
alias gmake='make'
alias cgrep='grep --color=always'
alias gm='gmake -j12 NO_OPTIMIZATION=Y'
alias gstub='gmake stub_targets -j12 NO_OPTIMIZATION=Y'
alias runctags='ctags -R --exclude="*test*" --exclude="*[Ss]tub*" --exclude="*ctcif*" --exclude="*include*"'
alias trim='grep -vi test | grep -vi stub | grep -vi tcov'
alias mt='~/local/Tools/Scripts/build_test.sh'
alias rg='grep -rI --color=auto'
alias myps='ps -leaf | grep jhogklin'
alias level='ps -o comm $PID | grep zsh | wc -l'
#alias zsh='/home/jhogklin/local/zsh/bin/zsh'
alias chrome='chromium-browser  --proxy-server=http://webproxy.scan.bombardier.com'
alias rmorig='rm **/*.orig'

# navigation
alias c='cd $HOME/$CURRENTPROJ/Implementation/TCC_SW'
alias a='cd $HOME/$CURRENTPROJ'
alias r='cd $HOME/$CURRENTPROJ/**/CBR3/Implementation/source'
alias et='cd $HOME/$CURRENTPROJ/**/CBR3/Implementation/source/InterfaceSpecific/ETCS'
alias i='cd $HOME/$CURRENTPROJ/**/CBI3/Implementation/source'
alias gpu='cd $HOME/$CURRENTPROJ/**/GPU3/Implementation/source'
alias tmp='cd $HOME/$CURRENTPROJ/**/TMP/Implementation/source'
alias cacore='cd $HOME/$CURRENTPROJ/**/CA/Implementation/source'
alias ila='cd $HOME/$CURRENTPROJ/Implementation/ILA*/Implementation/source'
alias rba='cd $HOME/$CURRENTPROJ/Implementation/RBA*/Implementation/source'
alias tm='cd $HOME/$CURRENTPROJ/Implementation/TM*/Implementation/source'
alias ca='cd $HOME/$CURRENTPROJ/Implementation/CA*/Implementation/source'

alias oldkaz='cd $HOME/$CURRENTPROJ && git checkout TCC_ER_CIS_SW_2.0.12 && git submodule update'
alias newkaz='cd $HOME/$CURRENTPROJ && git checkout master && cd Implementation/TCC_SW && git checkout er_cis'

# tmux alias
alias kaz1='Runtmuxinit.sh kaz1'
alias kaz2='Runtmuxinit.sh kaz2'
alias bv1='Runtmuxinit.sh bv1'
alias bv2='Runtmuxinit.sh bv2'

alias itt='~/scripts/itt_parse.py ~/gbguxs10/ConfigData/kaz_first/SWC_TCC_Uz_Bol_2.8/ConfigData/ConfigData.xml'
# GBGUXS10
#
#Boost
#
BOOST_ROOT=/opt/boost_1_34_1; export BOOST_ROOT
#
#ACE
#
ACE_ROOT=/opt/ACE-5.6.1/ACE_wrappers; export ACE_ROOT
#LD_LIBRARY_PATH=${ACE_ROOT}/lib:${LD_LIBRARY_PATH}; export LD_LIBRARY_PATH
#
#CPPUnit
#
CPPUNIT_ROOT=/opt/cppunit; export CPPUNIT_ROOT
LD_LIBRARY_PATH=${CPPUNIT_ROOT}/lib:${LD_LIBRARY_PATH}; export LD_LIBRARY_PATH
#
#QAC++
#
QACPP_ROOT=/opt/qacpp-2.5; export QACPP_ROOT
LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${QACPP_ROOT}/lib; export LD_LIBRARY_PATH
#
#Doxygen etc. (/usr/local/bin)
#
#PATH=${PATH}:/usr/local/bin:/usr/sfw/bin:/usr/sfw/sbin; export PATH
#
# XSD
#
XSD_ROOT=/opt/xsd; export XSD_ROOT
#
# Xerces-C
#
XERCES_ROOT=/opt/xerces; export XERCES_ROOT
#
# MySQL Connector C++
#
SQLCONNCPP_ROOT=/opt/tccdevelopment/mysqlcppconn; export SQLCONNCPP_ROOT

if [[ -z "$DISPLAY" && $(tty) == /dev/tty1 ]]
then
    startx
fi
