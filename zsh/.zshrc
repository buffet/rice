# Profile
EDITOR=vim
TERMINAL=urxvtc
PATH="$HOME/dotfiles/misc/scripts:$PATH"

export EDITOR TERMINAL PATH

# Emacs mode
bindkey -e

# Modules
autoload -Uz compinit add-zsh-hook

# Autocompletion
compinit
zstyle ':completion:*' menu select

# Prompt (for now)
GIT_PROMPT_PREFIX="%{%B%F{blue}%}(%{%F{red}%}"
GIT_PROMPT_SUFFIX="%{%b%f%}"
GIT_PROMPT_DIRTY="%{%F{blue}%}) %{%B%F{yellow}%}✗"
GIT_PROMPT_CLEAN="%{%F{blue}%})"

function _parse_git_dirty() {
	local STATUS=$(command git status --porcelain 2> /dev/null | tail -n1)
	if [[ -n $STATUS ]]; then
		echo "$GIT_PROMPT_DIRTY"
	else
		echo "$GIT_PROMPT_CLEAN"
	fi
}

function _git_prompt_info() {
	git rev-parse --git-dir > /dev/null 2>&1 || return
	local dirty="$(_parse_git_dirty)"
	local branch_name="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
	echo "${GIT_PROMPT_PREFIX}${branch_name}${dirty}${GIT_PROMPT_SUFFIX} "
}

_prompt_countingsort_precmd () {
	local ret_status="%(?:%B%F{green}➜ :%B%F{red}➜ )"
	PS1="${ret_status} %{%F{cyan}%}%c%{%f%} $(_git_prompt_info)%b%f"
}

add-zsh-hook precmd _prompt_countingsort_precmd

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
alias def-build='dnif default.nix "nix-build -E \"with import <nixpkgs> {}; callPackage ./default.nix {}\""'
alias def-shell='dnif default.nix "nix-shell -E \"with import <nixpkgs> {}; callPackage ./default.nix {}\" --pure"'
