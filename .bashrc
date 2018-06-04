#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias l='ls -a'
alias gl='git log --oneline --graph'

# Enable 256-color support (to resolve issues with colors in gnome terminal)
export TERM="gnome-256color"

