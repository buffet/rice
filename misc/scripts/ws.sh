#!/bin/sh

TERMINAL="${TERMINAL:-urxvtc}"

hc() {
	herbstclient "$@"
}

if ! [ "$(hc dump)" = "(clients vertical:0)" ]; then
	echo Non empty workspace. Exiting.
	exit 1
fi

# Wait for terms
herbstclient --idle | while read -r event; do
	case "$event" in
		*focus_changed*) c=$((c + 1))
	esac

	if [ "$c" -eq 3 ];then
		hc chain               \
			, split right 0.45 \
			, split below      \
			, shift down       \
			, focus up         \
			, shift right
		break
	fi
done &

"$TERMINAL" & disown
"$TERMINAL" & disown
"$TERMINAL" & disown
