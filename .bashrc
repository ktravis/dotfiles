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

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

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

git_branch() {
    b=$(git branch 2>/dev/null | grep '^*' | colrm 1 2)
    if [ ! -z "$b" ]; then
        echo "($b) "
    fi
}

PROMPT_COMMAND='PS1X=$(p="${PWD#${HOME}}"; [ "${PWD}" != "${p}" ] && printf "~";IFS=/; for q in ${p:1}; do printf /${q:0:1}; done; printf "${q:1}")'


PS1='\[\033[01;32m\]$(git_branch)\[\033[00m\]\[\033[01;34m\]$PS1X\[\033[00m\] \$ '
unset color_prompt force_color_prompt

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Environment variables
export PATH=$HOME/bin:$PATH
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH
export EDITOR=/usr/bin/vim

if [ -f "$HOME/.bashrc.aliases" ]; then
    . $HOME/.bashrc.aliases
fi

if [ -f "$HOME/.bashrc.local" ]; then
    . $HOME/.bashrc.local
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
FZF_CTRL_R_EDIT_KEY=ctrl-e
FZF_CTRL_R_EXEC_KEY=enter
source ~/.fzf-plugins/history-exec.bash

ccd() {
    mkdir -p $1 && cd $1
}
gprune() {
    git fetch -p && for branch in `git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}'`; do git branch -D $branch; done
}
