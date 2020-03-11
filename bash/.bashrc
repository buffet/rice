shopt -s cdspell checkjobs extglob globstar histappend nocaseglob
HISTCONTROL=erasedups:ignorespace
HISTFILE="$HOME/.cache/bash_history"

alias htop='htop -t'
alias mkdir='mkdir -p'

t() {
    if [[ $1 ]]; then
        mkdir -p "/tmp/$1"
    fi

    cd "/tmp/$1"
}

k() {
    local session repo
    repo="$(git rev-parse --show-toplevel 2>/dev/null)"

    if [[ $? -eq 0 ]]; then
        session="$repo"
    else
        session="$PWD"
    fi

    session="${session##*/}"

    if ! kak -l | grep -q "$session"; then
        kak -d -s "$session"
    fi

    kak -c "$session" "$@"
}

_prompt() {
    case $? in
        0) PS1='\[\e[36m\]>> \[\e[0m\]' ;;
        *) PS1='\[\e[31m\]>> \[\e[0m\]' ;;
    esac
}
PROMPT_COMMAND=_prompt
