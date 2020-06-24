test -z "$PROFILEREAD" && . /etc/profile || true

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_DIR="$HOME/.local/share"

export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export LESSHISTFILE="$XDG_CACHE_HOME/less_history"

export BROWSER=firefox
export EDITOR=kak

export MOZ_ENABLE_WAYLAND=1

export PATH="~/bin:$PATH"

if [ -e /home/buffet/.nix-profile/etc/profile.d/nix.sh ]; then . /home/buffet/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
