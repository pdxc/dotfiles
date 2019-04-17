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

# Conflicted files
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
	local files=(${$(git diff --relative --name-only $@ | fzf)//\/ })

	if [ -n "$files" ]; then
		echo $files
		if [ $(git rev-parse -q --verify $1) ]; then
			# https://github.com/airblade/vim-gitgutter "you can force vim-gitgutter to update its signs across all visible buffers with :GitGutterAll"
			vim ${files[*]} -c ":let g:gitgutter_diff_base='$1'|:sleep 900m |:GitGutterAll"
		else
			vim ${files[*]}
		fi
	fi
}

