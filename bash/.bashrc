#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# import bash aliases
if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi

# git autocomplete
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
# Append to history file; do not overwrite
shopt -s histappend
# Prevent accidental overwrites when using IO redirection
set -o noclobber
# updates terminal size after commands if necesssary
shopt -s checkwinsize
# expand "**" pattern
shopt -s globstar

# prompt
PS1='[\[\e[1;32m\]\u\[\e[m\]@\[\e[1;34m\]\h\[\e[m\] \W]\$ '

# for sudoedit
export EDITOR="nvim"
# default to less
export PAGER="less"
