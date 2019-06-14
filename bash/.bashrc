# Only run in interactive shells
if [[ $- != *i* ]]; then
    return
fi

HISTCONTROL=erasedups:ignorespace
HISTFILE="$HOME/.cache/bash_history"
HISTFILESIZE=100000
HISTSIZE=10000

shopt -s cdspell
shopt -s checkjobs
shopt -s extglob
shopt -s globstar
shopt -s histappend
shopt -s nocaseglob

alias e='exa'
alias eal='exa -al'
alias el='exa -l'
alias em='emacs'
alias htop='htop -t'
alias mkdir='mkdir -p'
alias ra='ranger'
alias v='nvim'

prompt() {
    case $? in
        0) PS1='\[\e[36m\]:-)' ;;
        *) PS1='\[\e[31m\]:-(' ;;
    esac

    PS1+='\[\e[0m\] '
}
PROMPT_COMMAND=prompt
