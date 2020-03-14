test -z "$PROFILEREAD" && . /etc/profile || true

export BROWSER=firefox
export EDITOR=kak
export INPUTRC="$HOME/.config/readline/inputrc"
export LESSHISTFILE="$HOME/.cache/less_history"
export XDG_CONFIG_DIR="$HOME/.config"

export MOZ_ENABLE_WAYLAND=1
