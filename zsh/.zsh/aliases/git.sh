#!/bin/sh

funciton gdno() {
	git diff --name-only $@
}
alias gdno=gdno

function ogd() {
	$EDITOR $(git diff --name-only $@)
}
alias ogd=ogd

