#!/bin/sh

funciton gdno() {
	git diff --relative --name-only $@
}
alias gdno=gdno

function ogd() {
	e $(git diff --relative --name-only $@)
}
alias ogd=ogd

