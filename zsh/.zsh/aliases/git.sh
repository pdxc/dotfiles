#!/bin/sh

function gs() {
	git status $@
}

function fp() {
	if [ $# -eq 0 ]; then
		git merge-base --fork-point master
	else
		git merge-base --fork-point $@
	fi
}

function gdc() {
	git diff --relative --name-only --diff-filter=U
}

function ogdc() {
	e $(git diff --relative --name-only --diff-filter=U)
}

function gdno() {
	git diff --relative --name-only $@
}

function ogd() {
	if [ $(git rev-parse -q --verify $1) ]; then
		echo $(git diff --relative --name-only $@)
		# https://github.com/airblade/vim-gitgutter "you can force vim-gitgutter to update its signs across all visible buffers with :GitGutterAll"
		vim -p $(git diff --relative --name-only $@) -c ":let g:gitgutter_diff_base='$1'|:GitGutterAll"
	else
		e $(git diff --relative --name-only $@)
	fi
}

