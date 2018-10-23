[[ -f ~/.profile ]] && . ~/.profile

# Emacs mode
bindkey -e

# Modules
autoload -Uz compinit add-zsh-hook

# Autocompletion
compinit
zstyle ':completion:*' menu select

# Prompt
build_prompt() {
	# Error code
	if [[ "$?" -eq 0 ]]; then
		prompt="%{%B%F{green}%}➜ "
	else
		prompt="%{%B%F{red}%}➜ "
	fi

	# Current dir
	if [[ "$PWD" = "$HOME" ]]; then
		prompt+="%{%B%F{cyan}%}~ "
	else
		prompt+="%{%B%F{cyan}%}${PWD##*/} "
	fi

	# git
	if git rev-parse --git-dir > /dev/null 2>&1; then
		# Branch name
		local branch_name="$(command git rev-parse --abbrev-ref HEAD 2> /dev/null)"
		prompt+="%{%B%F{blue}%}(%{%B%F{red}%}${branch_name}%{%B%F{blue}%}) "

		# Dirty
		git_status="$(command git status --porcelain 2> /dev/null | tail -n1)"
		if [[ -n "$git_status" ]]; then
			prompt+="%{%B%F{yellow}%}✗ "
		fi
	fi

	printf "%s" "${prompt}%{%b%f%}"
}

setopt PROMPT_SUBST
PS1='$(build_prompt)'

# Options
setopt CORRECT       # spellcheck
setopt GLOB_COMPLETE # complete globs
setopt NO_CASE_GLOB  # case insensitive
setopt EXTENDED_GLOB # extended globbering
setopt MENU_COMPLETE # case insensitive

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

HISTFILE=~/.zsh_history
SAVEHIST=10000
HISTSIZE=10000

setopt APPEND_HISTORY       # don't overwrite
setopt SHARE_HISTORY        # share between sessions
setopt HIST_IGNORE_DUPS     # only save last command
setopt HIST_IGNORE_ALL_DUPS # even if commands in between
setopt HIST_IGNORE_SPACE    # ignore lines starting with a space

# Search history
# TODO: Implement

# Aliases
alias v='vim'
alias g='git'
alias ra='ranger'
alias la='ls -l'
alias lsa='ls -al'
alias aba='abduco -a'
alias abc='abduco -c'
