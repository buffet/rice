shopt -s cdspell checkjobs extglob globstar histappend nocaseglob
HISTCONTROL=erasedups:ignorespace

alias mkdir='mkdir -p'
alias rg='rg -S'

PS0='\[\e[0m\]'
PS1='\[\e[1m\]      '

bind '"\C-o": "\C-a\C-k fg; if [[ $? == 1 ]]; then nvim; fi\n"'
bind '"\e\C-m": "\C-e | nvim\C-m"'
