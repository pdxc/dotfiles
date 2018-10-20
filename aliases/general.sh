#!/bin/sh

alias aliases="vim ~/dotfiles/aliases"

function of() {
	vim -O $(ag -l $1 $2)
}
alias of=of

function off() {
	vim -O $(ag -lg $1 $2)
}
alias off=off

