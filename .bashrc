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
HISTFILESIZE=100000

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

oldPS1='${debian_chroot:+($debian_chroot)}'
if [ "$color_prompt" = yes ]; then
    # PS1=$oldPS1'\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1=$oldPS1'\[\033[01;34m\]\w\[\033[00m\]/ '
    PROMPT_DIRTRIM=2
else
    # PS1=$oldPS1'\u@\h:\w\$ '
    PS1=$oldPS1'\W'
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
# 
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
export GIO_EXTRA_MODULES=/usr/lib/x86_64-linux-gnu/gio/modules/

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
alias S="python3 /home/ocean/Scheduler.py"
alias D="python3 /home/ocean/Pictures/BGs/add_text.py"
alias nmclin="nmcli n off; nmcli n on"
alias cleanlat="rm *.blg *.lof *.bcf *.aux *.bbl *.run.xml *.toc *.log *.out *.glo *.ist 2> /dev/null"
alias Scheduler="sublime-text.subl /home/ocean/Scheduler.py"
alias r="R"
alias backupScheduler="cp /home/ocean/Scheduler.py /home/ocean/Documents/GitHubDir/Productivity/Scheduler.py"
alias bas=bashrc
alias b='/home/ocean/backslash.sh'
alias updatebas="source ~/.bashrc"
alias backupbas="cp /home/ocean/.bashrc /home/ocean/Documents/GitHubDir/Productivity/"
alias backuplife="cp /home/ocean/Desktop/commands '/home/ocean/Desktop/List of mathematical symbols commonly used' /home/ocean/Desktop/Notepad /home/ocean/Documents/fault.log /home/ocean/Desktop/Schedule.txt /home/ocean/*.sh /home/ocean/Documents/GitHubDir/Productivity/OtherLifeStuff/."
alias backupsubl="cp /home/ocean/.config/sublime-text-3/Packages/*.sublime-macro /home/ocean/.config/sublime-text-3/Packages/User/*.sublime-keymap /home/ocean/Documents/GitHubDir/Productivity/OtherLifeStuff/sublime/."
alias p="echo 'from numpy import cos, arccos, sin, arctan, tan, pi, sqrt, exp; from numpy import array as ary; from numpy import log as ln; import numpy as np; tau = 2*pi
from matplotlib import pyplot as plt' | xsel -i -b"
alias pw="pwd | tr -d '\n' | xsel -ib"
#alias pip=pip3
#alias ipython=ipython3
#alias python=python3
#alias p38=python3.8
alias pwdc="pwd | xsel -i -b"
#alias tor=/usr/bin/tor-browser_en-US/start-tor-browser.desktop
# Alias definitions.
alias xopen=xdg-open
alias njoy=/home/ocean/Documents/NJOY21/bin/njoy21
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
#alias  py3="conda activate py38"
#Conda has two environments: one called (for legacy reaons) dowgrade, which actually contains an upgraded version (python3.8); and the other is simply base.
alias conact='source /home/ocean/miniconda3/bin/activate'
alias conbase='conact base' #Python3.6.9, works.
alias conlat='conact latest'
alias concan='conact canary'
alias envenv="source /home/ocean/env/bin/activate"
concan
alias fispact=/home/ocean/Documents/FISPACT-II-3-20/fispact/exec/Ubuntu-14.04-X86/gfortran/fispact
alias compress=/home/ocean/Documents/FISPACT-II-3-20/fispact/exec/Ubuntu-14.04-X86/gfortran/compress_xs_endf
fispact=/home/ocean/Documents/FISPACT-II-3-20/fispact/exec/Ubuntu-14.04-X86/gfortran/fispact; export fispact
compress_xs_endf=/home/ocean/Documents/FISPACT-II-3-20/fispact/exec/Ubuntu-14.04-X86/gfortran/compress_xs_endf; export compress_xs_endf
alias extract_xs_endf=/home/ocean/Documents/FISPACT-II-3-20/fispact/exec/Ubuntu-14.04-X86/gfortran/extract_xs_endf
#go:
export PATH=$PATH:/usr/local/go/bin
export CHETHOR="MSc_PTNR_23@che-thor.bham.ac.uk"
export PHYMAT4="HYW543@phymat4.adf.bham.ac.uk"
export PHYMAT6="HYW543@phymat6.adf.bham.ac.uk"
export CHI=$CHETHOR
export ERIK="owong@erik.ccfe.ac.uk"
export CUM="owong@login1.cumulus.hpc.l"
export FACE="167.71.140.134"
alias  phymat="sshy -p 22722 $PHYMAT4"
alias  scpp="scp -P 22722"
alias  er="sshy $ERIK"
alias  cu="sshy $CUM"
alias  savedir=backupdir

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
function CPP() {
    g++ $1.cpp -o $1.out
    echo "End of compiling. Running program..."
    echo "|"
    echo "|"
    echo "|"
    echo "|"
    echo "|"
    ./$1.out
}

#Function to compare content of two folders
function lsdiff(){
    for f in $1*; do
        f=${f#$1} #cut off the excess
        echo $f:
        diff -q $1$f $2$f
        echo "" #print newline
    done
    }
#example usage: ocean@ocean-UX550VE:~/.../All_spectra_in_175/data_package_175convert$ lsdiff ./ /media/ocean/OCEANUSB/Culham/UKAEA_IAEA_Compendium/All_spectra_corrected/

#3 in 1 command for git commit
function gitall(){
    git add .
    git commit -m  "$1"
    git push origin master
    }
function gitcompush(){
    git commit -m "$1"
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
    mkdir $1
    cd $1
    git init
    git add .
    gitcom "First commit"
    git remote add origin git@github.com:OceanNuclear/$1.git
    git push origin master
}
#perhaps I have to export the following package list before installation will happen properly?
#export PKG_CONFIG_PATH=/usr/lib/pkgconfig
function fr(){
    freia_e=".hpc.l"
    freia_s="freia0"
    sshy owong@$freia_s$1$freia_e
}
function pdfwc(){
    for i in $(ls *.pdf)
    do
    echo ${i}
    pdftotext ${i} - | wc
    echo
    done
}

function searchhist(){
    grep $1 ~/.bash_history
}
#grep the pattern give in the .tex that's present in the current directory
function texgrep(){
    if [ $# -gt 1 ]
    then
        grep -n "$*" $(ls *.tex| head -n1)
    else
        grep -n $1 $(ls *.tex| head -n1)
    fi
}

#Given the line number in the .tex file, show where that line is using "less <pdf>"
function cursorpdftotext(){
    fname=$(ls *.tex | head -n1 | cut -d'.' -f1) #get the file name
    threewords=$(sed -n $1p ${fname}.tex | awk '{print $2 " " $3 " " $4}') #get the 2nd-4th words of that line in the .tex file
    page=$(pdfgrep "$threewords" -n $fname.pdf | cut -d ' ' -f1 | sed 's/\://g') #get the page number
    pdftotext $fname.pdf -f $page -l $page -
}
function cursorless(){
    echo "usage: cursorless <line number in the .tex file>"
    echo "then, when in 'less', type /, type ctrl+shift+v"
    fname=$(ls *.tex | head -n1 | cut -d'.' -f1) #get the file name, assuming we're already in the same directory as the .tex file and the .pdf file.
    threewords=$(sed -n $1p ${fname}.tex | awk '{print $2 " " $3 " " $4}') #get the 2nd-4th words of that line in the .tex file
    echo $threewords | xsel -i -b #copy it into the clipboard
    echo $threewords
    less $fname.pdf
}
function backupdir(){
    git add .
    gitcom "Routine sync-ing up of my files with the remote."
    git push origin master
}
function breakline(){
    #tr ":" '\n' $1
    sed 's/[: ]/\n/g' #use regex
    #usage: example: echo $PATH | break
}
function convertvideo(){
    #$1 should not include the suffix .mp4
    ffmpeg -i $1.mp4 $1.webm
    ffmpeg -i $1.mp4 $1.ogv
    ffmpeg -i $1.mp4 $1.ogg
}
function license_mit(){
    cp /home/ocean/Templates/LICENSE-MIT ./LICENSE
    year=$(date +"%Y")
    sed -i "s/\[year\]/${year}/g" LICENSE
}
function license_gnu(){
    cp /home/ocean/Templates/LICENSE-GNU ./LICENSE
    year=$(date +"%Y")
    echo "program name? "
    sed -i "s/\[year\]/${year}/g" LICENSE
    read program
    sed -i "s/\[program\]/${program}/g" LICENSE
    echo "one line description? "
    read onelinedescription
    sed -i "s/\[one line description\]/${onelinedescription}/g" LICENSE
}
function license_apc(){
    cp /home/ocean/Templates/LICENSE-APC ./LICENSE
    year=$(date +"%Y")
    sed -i "s/\[yyyy\]/${year}/g" LICENSE
}
