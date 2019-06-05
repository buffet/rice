if [[ -n $SESSION_VARS_SOURCED ]]; then
    return
fi

SESSION_VARS_SOURCED=1

export BROWSER=chromium
export INPUTRC="$HOME/.config/readline/inputrc"
export LESSHISTFILE="$HOME/.cache/less_history"
