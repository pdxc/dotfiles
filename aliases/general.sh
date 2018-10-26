#!/bin/sh

alias aliases="vim ~/dotfiles/aliases"

function of() {
	vim -O $(ag -l $@)
}
alias of=of

function off() {
	vim -O $(ag -lg $@)
}
alias off=off

