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
	$EDITOR $(ag -l $@)
}
alias of=of

function off() {
	$EDITOR $(ag -lg $@)
}
alias off=off

