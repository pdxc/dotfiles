#!/bin/sh

alias aliases="vim ~/.zsh/aliases"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Always ls after cd
function c() {
	cd $1 && ls -lah
}
alias cd=c

function of() {
	e $(ag -l $@)
}
alias of=of

function off() {
	e $(ag -lg $@)
}
alias off=off

