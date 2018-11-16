#!/bin/sh

alias aliases="vim ~/.zsh/aliases"

function of() {
	$EDITOR $(ag -l $@)
}
alias of=of

function off() {
	$EDITOR $(ag -lg $@)
}
alias off=off

