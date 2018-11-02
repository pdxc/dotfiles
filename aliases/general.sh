#!/bin/sh

alias aliases="vim ~/dotfiles/aliases"

function of() {
	vim $(ag -l $@)
}
alias of=of

function off() {
	vim $(ag -lg $@)
}
alias off=off

