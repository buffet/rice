test -z "$PROFILEREAD" && . /etc/profile || true

export XDG_CONFIG_HOME="$HOME/etc"
export XDG_CACHE_HOME="$HOME/var/cache"
export XDG_DATA_DIR="$HOME/var/local"

export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export LESSHISTFILE="$XDG_CACHE_HOME/less_history"

export BROWSER=firefox
export EDITOR=kak

export MOZ_ENABLE_WAYLAND=1

export PATH="~/bin:$PATH"
