PATH+=":${HOME}/Documents/bigmac:${HOME}/.bin"
EDITOR='vim'
BROWSER='qutebrowser'
TERMINAL='st'
QT_WAYLAND_FORCE_DPI=180

CFLAGS='-O2'
CXXFLAGS="${CFLAGS}"
CPPFLAGS=
LDFLAGS=

export PATH EDITOR BROWSER TERMINAL QT_WAYLAND_FORCE_DPI CFLAGS CXXFLAGS CPPFLAGS

if [[ "$(tty)" = "/dev/tty1" ]]; then
#	pgrep startx || exec startx
	exec sway
fi
