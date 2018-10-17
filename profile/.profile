PATH+=":${HOME}/bin"
export EDITOR='vim'
export BROWSER='qutebrowser'
export TERMINAL='st'

if [[ "$(tty)" = "/dev/tty1" ]]; then
	pgrep startx || exec startx
fi
