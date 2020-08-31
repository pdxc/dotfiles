#!/bin/bash

alias aliases="vim ~/.zsh/aliases"
alias secrets="vim ~/.zsh/secrets"
alias snippets="vim ~/.vim/minisnip"

alias vrc="vim ~/.vimrc"
alias zrc="vim ~/.zshrc"
alias trc="vim ~/.tmux.conf"

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_R_OPTS="--preview 'echo {} |sed -e \"s/^ *\([0-9]*\) *//\" -e \"s/^\\(.\\{,\$COLUMNS\\}\\).*$/\\1/\"; echo {} |sed -e \"s/^ *[0-9]* *//\" -e \"s/^.\\{,\$COLUMNS\\}//g\" -e \"s/.\\{1,\$((COLUMNS-2))\\}/⏎ &\\n/g\"' --preview-window down:5 --bind ?:toggle-preview --bind [:preview-down --bind ]:preview-up"
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
	local candidates
	local files

	if [ "$#" -eq 0 ]; then
		files=(${$(fzf)//\/ })
	else
		candidates=$(ag -lg $@)
		if [ -n "$candidates" ]; then
			files=(${$(echo "${candidates}" | fzf)//\/ })
		fi
	fi
	if [ -n "$files" ]; then
		echo $files
		vim ${files[*]}
	fi
}

