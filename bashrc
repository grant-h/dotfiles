# Grant Hernandez's personal bashrc

# add my own executable directories
export PATH="$PATH:$HOME/bin:/sbin:/usr/sbin"
export PATH="$HOME/ida-6.4/:$PATH"

if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# global viewers
export EDITOR=/usr/bin/vim
export MANPAGER=/usr/bin/vimmanpager
# this is causing issues with Git
#export PAGER=/usr/bin/vimpager

# prevents duplicate lines from being put in the history
# and allows a leading space to hide the command from the history
export HISTCONTROL="ignoreboth"
export HISTSIZE="5000"

# append our entries to the history
shopt -s histappend

# allow for notification on completed shell jobs!
export PROMPT_COMMAND="echo -ne '\a'"

###### Aliases ######
alias vi='vim'
alias rm='rm -I'
alias ls='ls --color=auto --group-directories-first --file-type'
alias cu='cd ..; ls'
alias mplayer='mplayer -softvol -softvol-max 900.0'
# Once more, with emphasis
alias fucking='sudo' # i.e 'fucking rm -rf /'
alias feh='feh -Z -B black -.' # fit picture and bg black
alias unsafe="source $HOME/bin/unsafe"
alias present="source $HOME/bin/present"

tbgr() { grep -r "$1" .; }

# contain the color variables to the function
ps1_init() {
  local NONE="\[\033[0m\]"    # unsets color

  # regular colors
  local K="\[\033[0;30m\]"    # black
  local KI="\[\033[1;30m\]"   # black
  local R="\[\033[0;31m\]"    # red
  local RI="\[\033[1;31m\]"   # red
  local G="\[\033[0;32m\]"    # green
  local GI="\[\033[1;32m\]"   # green
  local Y="\[\033[0;33m\]"    # yellow
  local YI="\[\033[1;33m\]"   # yellow
  local B="\[\033[0;34m\]"    # blue
  local BI="\[\033[1;34m\]"   # blue
  local M="\[\033[0;35m\]"    # magenta
  local MI="\[\033[1;35m\]"   # magenta
  local C="\[\033[0;36m\]"    # cyan
  local CI="\[\033[1;36m\]"   # cyan
  local W="\[\033[0;37m\]"    # white
  local WI="\[\033[1;37m\]"   # white

  export PS1="${RI}[${CI}\u${WI} \w ${RI}]${NONE} "
}

ps1_init
unset ps1_init # clear the namespace

# java configuration
#_JAVA_OPTIONS="-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
export _JAVA_OPTIONS="${_JAVA_OPTIONS} -Dawt.useSystemAAFontSettings=lcd"

# Add bash completion
# source /etc/profile.d/bash-completion.sh
