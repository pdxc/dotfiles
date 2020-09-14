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

function open_git_diff_split() {
	local files=(${$(git diff --relative --name-only $@ | fzf)//\/ })

	if [ -n "$files" ]; then
		echo $files
		if [ $(git rev-parse -q --verify $1) ]; then
			# https://github.com/airblade/vim-gitgutter "you can force vim-gitgutter to update its signs across all visible buffers with :GitGutterAll"
			vim -p ${files[*]} +"tabdo Gdiff $1" +"let g:gitgutter_diff_base='$1'" +"MBEOpenAll"
		else
			vim -p ${files[*]} +"tabdo Gdiff"
		fi
	fi
}
alias ogds=open_git_diff_split

# git log show with fzf
function fuzzy_git_log() {

  # param validation
  if [[ ! `git log -n 1 $@ | head -n 1` ]] ;then
    return
  fi

  # filter by file string
  local filter
  # param existed, git log for file if existed
  if [ -n $@ ] && [ -f $@ ]; then
    filter="-- $@"
  fi

  # git command
  local gitlog=(
    git log
    --graph --color=always
    --abbrev=7
    --format='%C(auto)%h %an %C(blue)%s %C(yellow)%cr'
    $@
  )

  # fzf command
  local fzf=(
    fzf
    --ansi --no-sort --reverse --tiebreak=index
    --preview "f() { set -- \$(echo -- \$@ | grep -o '[a-f0-9]\{7\}'); [ \$# -eq 0 ] || git show --color=always \$1 $filter; }; f {}"
    --bind "ctrl-q:abort,ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % $filter | less -R') << 'FZF-EOF'
                {}
                FZF-EOF"
   --preview-window=right:60%
  )

  # piping them
  $gitlog | $fzf
}
alias fglog=fuzzy_git_log
