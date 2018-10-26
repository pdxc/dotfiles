#!/bin/sh

function ogd() {
	vim -O $(git diff --name-only $@)
}
alias ogd=ogd

