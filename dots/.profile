[ "$PROFILE_LOADED_" ] && return
export PROFILE_LOADED_=1

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

PATH="$PATH:$HOME/.local/bin:$HOME/.roswell/bin"
