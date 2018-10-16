#!/bin/sh

function ogd() {
	v -O $(git diff --name-only $1)
}
alias ogd=ogd
