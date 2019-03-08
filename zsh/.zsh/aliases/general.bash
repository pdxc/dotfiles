#!/bin/bash

alias aliases="vim ~/.zsh/aliases"
alias secrets="vim ~/.zsh/secrets"

alias vrc="vim ~/.vimrc"
alias zrc="vim ~/.zshrc"
alias trc="vim ~/.tmux.conf"

# Always ls after cd
c() {
	cd $1 && ls -lah
}
alias cd=c

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
alias fzf="fzf -m --bind ctrl-a:toggle-all"
alias pe=path-extractor

of() {
	local to_print=""
	local command_first_half=""
	local command_second_half=""
	local first_half_separator=""
	local second_half_separator="|:tabnext |"
	for i in $(ag -l $@); do
		to_print="${to_print} ${i}"
		command_first_half="${command_first_half}${first_half_separator}:e ${i}"
		first_half_separator="|:tabnew |"
		command_second_half="${command_second_half}${second_half_separator}:execute "\""normal\! G\$/\\\c${1}\\<cr>"\"
	done
	echo ${to_print}
	vim -p -c "${command_first_half}${command_second_half}|:tabnext"
}

off() {
	e $(ag -lg $@)
}

