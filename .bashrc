# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
#alias rm="rm -I"
alias rmi="rm -I"
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

#alias for convenience:
alias conv="libreoffice --headless --convert-to pdf"
alias rungo="go build; ./go"
alias sshy="ssh -Y"
alias bashrc="gedit /home/ocean/.bashrc"
alias gitcom="git commit -m"
alias gitpush="git push origin master"
alias S="/home/ocean/Scheduler.py"
alias nmclin="nmcli n off; nmcli n on"
alias Scheduler="sublime-text.subl /home/ocean/Scheduler.py"
alias r="R"
alias backupScheduler="cp /home/ocean/Scheduler.py /home/ocean/Documents/GitHubDir/Productivity/Scheduler.py"
alias bas=bashrc
alias updatebas="source ~/.bashrc"
alias backupbas="cp /home/ocean/.bashrc /home/ocean/Documents/GitHubDir/Productivity/"
alias backuplife="cp /home/ocean/Desktop/commands '/home/ocean/Desktop/List of mathematical symbols commonly used' /home/ocean/Desktop/Notepad /home/ocean/Documents/fault.log /home/ocean/Desktop/Schedule.txt /home/ocean/*.sh /home/ocean/Documents/GitHubDir/Productivity/OtherLifeStuff/."
alias p="echo 'from numpy import cos, arccos, sin, arctan, tan, pi, sqrt; from numpy import array as ary; import numpy as np; tau = 2*pi
from matplotlib import pyplot as plt'"
#alias tor=/usr/bin/tor-browser_en-US/start-tor-browser.desktop
# Alias definitions.
alias xopen=xdg-open
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#added by Anaconda3 installer
export PATH="/home/ocean/anaconda3/bin:$PATH"
fispact=/home/ocean/Documents/FISPACT-II-3-20/fispact/exec/Ubuntu-14.04-X86/gfortran/fispact; export fispact
compress=/home/ocean/Documents/FISPACT-II-3-20/fispact/exec/Ubuntu-14.04-X86/gfortran/compress_xs_endf; export compress
#go:
export PATH=$PATH:/usr/local/go/bin
export CHETHOR="MSc_PTNR_23@che-thor.bham.ac.uk"
export PHYMAT4="HYW543@phymat4.adf.bham.ac.uk"
export PHYMAT6="HYW543@phymat6.adf.bham.ac.uk"
export CHI=$CHETHOR
alias  phymat="sshy -p 22722 $PHYMAT4"
alias  scpp="scp -P 22722"
#Fortran compile and run command:
function fortify(){
	gfortran $1.f -o $1.out
	echo "End of compiling. Running program..."
	echo "|"
	echo "|"
	echo "|"
	echo "|"
	echo "|"
	./$1.out
	}
alias F=fortify
#Function to compare content of two folders
function lsdiff(){
	for f in $1*; do
		f=${f#$1} #cut off the excess
		echo $f:
		diff -q $1$f $2$f
		echo "" #print newline
	done
	}
#3 in 1 command for git commit
function gitall(){
	git add .
	git commit -m  "$1"
	git push origin master
	}
function bibcompile(){ #Don't type the .tex after it.
	pdflatex $1.tex
	bibtex $1.aux
	pdflatex $1.tex
	pdflatex $1.tex
}
function silentlat(){
	pdflatex $1.tex > /dev/null
}
function convq(){
	conv "$@" 2> /dev/null
	 #redirect error into null, so they don't get printed
}
function gitinit(){
	cd $1
	git init
	git add .
	gitcom "First commit"
	git remote add origin git@github.com:OceanNuclear/$1.git
	git push origin master
}
#perhaps I have to export the following package list before installation will happen properly?
#export PKG_CONFIG_PATH=/usr/lib/pkgconfig
