PATH+=":${HOME}/bin"
EDITOR='vim'
BROWSER='qutebrowser'
TERMINAL='st'

CFLAGS='-O2'
CXXFLAGS="${CFLAGS}"
CPPFLAGS=
LDFLAGS=

export PATH EDITOR BROWSER TERMINAL CFLAGS CXXFLAGS CPPFLAGS

if [[ "$(tty)" = "/dev/tty1" ]]; then
	pgrep startx || exec startx
fi
