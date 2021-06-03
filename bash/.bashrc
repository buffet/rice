# exit if not run interactively
[[ $- != *i* ]] && return

shopt -s cdspell checkjobs extglob globstar histappend nocaseglob
HISTCONTROL=erasedups:ignorespace
HISTFILE="$XDG_CACHE_HOME/bash_history"

alias ..='cd ..'
alias cd..='cd ..'
alias htop='htop -t'
alias mkdir='mkdir -p'
alias rg='rg -S'
alias v='f -e nvim'

t() {
    if [[ $1 ]]; then
        mkdir -p "/tmp/$1"
    fi

    cd "/tmp/$1"
}

__prompt() {
    case $? in
        0) PS1='\[\e[36m\]>> \[\e[0m\]' ;;
        *) PS1='\[\e[31m\]>> \[\e[0m\]' ;;
    esac
}
PROMPT_COMMAND=__prompt

eval "$(fasd --init auto)"
_fasd_bash_hook_cmd_complete v

eval "$(direnv hook bash)"
