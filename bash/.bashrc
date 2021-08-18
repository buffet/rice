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
    case $1 in
        u*) git -C ~/todo commit -am 'docs: update' && git -C ~/todo push ;;
        p*) git -C ~/todo pull ;;
        *) nvim ~/todo/todo ;;
    esac
}

eval "$(fasd --init auto)"
_fasd_bash_hook_cmd_complete v

eval "$(direnv hook bash)"

__prompt() {
    case $? in
        0) PS1='\[\e[34m\]' ;;
        *) PS1='\[\e[31m\]' ;;
    esac

    if [[ "$PWD" = "$HOME" ]]; then
        PS1+='~'
    else
        PS1+="${PWD##*/}"
    fi

    PS1+='\[\e[0m\] '
}
PROMPT_COMMAND="__prompt;$PROMPT_COMMAND"
