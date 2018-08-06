#! /usr/bin/zsh

GIT_PROMPT_PREFIX="%{%B%F{blue}%}(%{%F{red}%}"
GIT_PROMPT_SUFFIX="%{%b%f%}"
GIT_PROMPT_DIRTY="%{%F{blue}%}) %{%B%F{yellow}%}✗"
GIT_PROMPT_CLEAN="%{%F{blue}%})"

# Checks if working tree is dirty
function parse_git_dirty() {
	local STATUS=$(command git status --porcelain 2> /dev/null | tail -n1)
	if [[ -n $STATUS ]]; then
		echo "$GIT_PROMPT_DIRTY"
	else
		echo "$GIT_PROMPT_CLEAN"
	fi
}

function git_prompt_info() {
	local dirty="$(parse_git_dirty)"
	local branch_name="$(git rev-parse --abbrev-ref HEAD)"
	echo "${GIT_PROMPT_PREFIX}${branch_name}${dirty}${GIT_PROMPT_SUFFIX}"
}

prompt_countingsort_precmd () {
	local ret_status="%(?:%B%F{green}➜ :%B%F{red}➜ )"
	PS1="${ret_status} %{%F{cyan}%}%c%{%f%} $(git_prompt_info) "
}

add-zsh-hook precmd prompt_countingsort_precmd
