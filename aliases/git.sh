#!/bin/sh

function ogd() {
	vim $(git diff --name-only $@)
}
alias ogd=ogd

