# exit if not run interactively
[[ $- != *i* ]] && return

shopt -s cdspell checkjobs extglob globstar histappend nocaseglob
HISTSIZE=50000
HISTCONTROL=erasedups:ignorespace

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
        *) "$EDITOR" ~/todo/todo ;;
    esac
}

fmt() {
    [ -f .clang-format ] && {
        find src -type f -name '*.[ch]' -print | xargs -d '\n' clang-format -i "$@"
        return
    }

    [ -f Cargo.toml ] && {
        cargo fmt "$@"
        return
    }
}

__prompt() {
    case $? in
        0) PS1='; ' ;;
        *) PS1='\[\e[31m\]; \[\e[0m\]' ;;
    esac
}
PROMPT_COMMAND="__prompt;$PROMPT_COMMAND"

. "$HOME/.cargo/env"

eval "$(direnv hook bash)"

pgrep -u "$USER" -x ssh-agent >/dev/null || ssh-agent -t 5m >"$XDG_RUNTIME_DIR/ssh-agent.env"
[[ "$SSH_AUTH_SOCK" ]] || . "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
