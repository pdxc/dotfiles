#!/bin/sh

funciton gdno() {
	git diff --relative --name-only $@
}
alias gdno=gdno

function ogd() {
	$EDITOR $(git diff --relative --name-only $@)
}
alias ogd=ogd

