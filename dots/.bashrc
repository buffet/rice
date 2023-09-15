shopt -s cdspell checkjobs extglob globstar histappend nocaseglob
HISTCONTROL=erasedups:ignorespace

alias mkdir='mkdir -p'
alias rg='rg -S'

bind '"\C-o": "\C-a\C-k fg; if [[ $? == 1 ]]; then nvim; fi\n"'
bind '"\e\C-m": "\C-e | nvim\C-m"'


__prompt() {
    local status="$?"

    PS1='\[\e[0m\e[1m\]['

    case $status in
        0) PS1+='\[\e[36m\]' ;;
        *) PS1+='\[\e[31m\]' ;;
    esac

    if [[ "$PWD" = "$HOME" ]]; then
        PS1+="~"
    elif [[ "$PWD" = / ]]; then
        PS1+=/
    else
        PS1+="${PWD##*/}"
    fi

    PS1+='\[\e[0;1m\]]\[\e[0m\]'

    [[ $DISTROBOX_ENTER_PATH ]] && PS1+="'"

    PS1+=' '
}
PROMPT_COMMAND=__prompt
