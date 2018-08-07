# Quit if not running interactively
[[ $- != *i*  ]] && return

# Colors
color_grey='\e[1;30m'
color_red='\e[0;31m'
color_RED='\e[1;31m'
color_green='\e[0;32m'
color_GREEN='\e[1;32m'
color_yellow='\e[0;33m'
color_YELLOW='\e[1;33m'
color_purple='\e[0;35m'
color_PURPLE='\e[1;35m'
color_white='\e[0;37m'
color_WHITE='\e[1;37m'
color_blue='\e[0;34m'
color_BLUE='\e[1;34m'
color_cyan='\e[0;36m'
color_CYAN='\e[1;36m'
color_none='\e[0m'

# Options
set -o vi           # vi mode
shopt -s nocaseglob # case independent glob

# Smash escape
bind -m vi-insert '"kj":vi-movement-mode' 

# Prompt
build_prompt () {
	# Error code
	if [[ "$?" -eq 0 ]]; then
		prompt="${color_GREEN}➜ "
	else
		prompt="${color_RED}➜ "
	fi

	# Current dir
	if [[ "$PWD" = "$HOME" ]]; then
		prompt="${prompt}${color_CYAN}~ "
	else
		prompt="${prompt}${color_CYAN}${PWD##*/} "
	fi

	# git
	if git rev-parse --git-dir > /dev/null 2>&1; then
		# Branch name
		local branch_name="$(command git rev-parse --abbrev-ref HEAD 2> /dev/null)"
		prompt="${prompt}${color_BLUE}(${color_RED}${branch_name}${color_BLUE}) "

		# Dirty
		git_status="$(command git status --porcelain 2> /dev/null | tail -n1)"
		if [[ -n "$git_status" ]]; then
			prompt="${prompt}${color_YELLOW}✗ "
		fi
	fi

	echo -e "$prompt$color_none"
}

PS1='$(build_prompt)'

# Functions
irc () {
	local irc='irc'

	if abduco | grep -q "$irc"; then
		abduco -a "$irc"
	else
		abduco -c "$irc"
	fi
}

# Aliases
alias aba='abduco -a'
alias abc='abduco -c'
alias g='git'
alias la='ls -l'
alias ls='ls --color=auto'
alias lsa='ls -al'
alias ra='ranger'
alias v='vim'

# Start X server
if [[ "$(tty)" = "/dev/tty1" ]]; then
	pgrep xinit || exec startx
fi
