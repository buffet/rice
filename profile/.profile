test -z "$PROFILEREAD" && . /etc/profile || true

export BROWSER=firefox
export EDITOR=kak
export INPUTRC="$HOME/.config/readline/inputrc"
export LESSHISTFILE="$HOME/.cache/less_history"
export XDG_CONFIG_DIR="$HOME/.config"

export MOZ_ENABLE_WAYLAND=1

# rust stuff
export PATH="/home/buffet/.local/cargo/bin:$PATH"
export CARGO_HOME="$HOME/.local/cargo"
export RUSTUP_HOME="$HOME/.local/rustup"

if [ -e /home/buffet/.nix-profile/etc/profile.d/nix.sh ]; then . /home/buffet/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

export PATH="~/bin:$PATH"
