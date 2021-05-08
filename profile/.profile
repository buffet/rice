[ "$READPROFILE" ] && return

. /etc/profile || true

export READPROFILE=1

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_DIR="$HOME/.local/share"

export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export LESSHISTFILE="$XDG_CACHE_HOME/less_history"

export BROWSER=firefox
export EDITOR=nvim

# load nix stuff
[ -f ~/.nix-profile/etc/profile.d/nix.sh ] && . ~/.nix-profile/etc/profile.d/nix.sh
