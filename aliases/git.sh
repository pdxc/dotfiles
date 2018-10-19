#!/bin/sh

function ogd() {
	vim -O $(git diff --name-only $1)
}
alias ogd=ogd

