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

of() {
	## Alternate version that opens a tab for each matching line
	#local command=""
	#local separator=""
	#for i in $(ag --column ${@} | cut -d ':' -f 1-3); do
	#	local f=$(echo ${i} | cut -d ':' -f 1)
	#	local l=$(echo ${i} | cut -d ':' -f 2)
	#	local c=$(echo ${i} | cut -d ':' -f 3)
	#	command="${command}${separator}:e ${f}|:let @/="\""${@}"\""|:set hls|:call cursor(${l},${c})"
	#	separator="|:tabnew |"
	#done
	#echo ${command}
	#vim -p -c "${command}"

	local to_print=""
	local command=""
	local separator=""
	for i in $(ag -l $@); do
		to_print="${to_print} ${i}"
		command="${command}${separator}:e ${i}|:execute "\""normal\! G\$/${@}\\<cr>"\"
		separator="|:tabnew |"
	done
	echo ${to_print}
	vim -p -c "${command}"
}

off() {
	e $(ag -lg $@)
}

