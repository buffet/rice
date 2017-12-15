#!/bin/env bash

# Just a dirty script for lemonbar,
# you need to use 'siji' font for icons.

# main monitor
monitor=${1:-0}

# padding
herbstclient pad $monitor 20

# settings
RES="x20+1920x"
FONT="*-siji-medium-r-*-*-10-*-*-*-*-*-*-*"
#FONT2="*-benis-lemon-medium-r-*-*-10-*-*-*-*-*-*-*"
FONT2="-*-cure.se-medium-r-*-*-11-*-*-*-*-*-*-*"
FONT3="IPAGothic:pixelsize=11:antialias=false"
#FONT3="Kochi Gothic-8" # stopped working; fontconfig issues?

BG="#1D1F21"
BA="#242629"
FG="#A8A8A8"
BLK="#262626"
RED="#7d3750"
YLW="#917154"
BLU="#45536E"
GRA="#898989"
VLT="#7B3D93"

# icons
st="%{F$YLW}  %{F-}"
sm="%{F$RED}  %{F-}"
sv="%{F$BLU}  %{F-}"
sd="%{F$VLT}  %{F-}"

# functions
set -f

function uniq_linebuffered() {
    awk -W interactive '$0 != l { print ; l=$0 ; fflush(); }' "$@"
}

# events
{
    # now playing
    mpc idleloop player | cat &
    mpc_pid=$!

    # volume
    while true ; do
        echo "vol $(amixer get Master | tail -1 | sed 's/.*\[\([0-9]*%\)\].*/\1/')"
	sleep 1 || break
    done > >(uniq_linebuffered) &
    vol_pid=$!

    # date
    while true ; do
        date +'date_min %b %d %A '%{F$RED}%{F-}' %H:%M'
        sleep 1 || break
    done > >(uniq_linebuffered) &
    date_pid=$!

    # herbstluftwm
    herbstclient --idle

    # exiting; kill stray event-emitting processes
    kill $mpc_pid $vol_pid $date_pid
} 2> /dev/null | {
    TAGS=( $(herbstclient tag_status $monitor) )
    unset TAGS[${#TAGS[@]}]
    time=""
    song="nothing to see here"
    windowtitle="what have you done?"
    visible=true

        while true ; do
        echo -n "%{l}"
        for i in "${TAGS[@]}" ; do
            case ${i:0:1} in
                '#') # current tag
                    echo -n "%{B$RED}"
                    ;;
                '+') # active on other monitor
                    echo -n "%{B$YLW}"
                    ;;
                ':')
                    echo -n "%{B-}"
                    ;;
                '!') # urgent tag
                    echo -n "%{U$YLW}"
                    ;;
                *)
                    echo -n "%{B-}"
                    ;;
            esac
            echo -n " ${i:1} %{B-}"
        done

	# center window title
	echo -n "%{c}$st${windowtitle//^/^^}"

        # align right
        echo -n "%{r}"
        echo -n "$sm"
        echo -n "$song" %{F$YLW}"$song2"%{F-}
        echo -n "$sv"
        echo -n "$volume"
        echo -n "$sd"
        echo -n "$date "
        echo ""

        # wait for next event
        read line || break
        cmd=( $line ) =
        # find out event origin
        case "${cmd[0]}" in
            tag*)
                TAGS=( $(herbstclient tag_status $monitor) )
                unset TAGS[${#TAGS[@]}]
                ;;
            mpd_player|player)
                song="$(mpc -f %artist% current)"
		song2="$(mpc -f %title% current)"
                ;;
            vol)
                volume="${cmd[@]:1}"
                ;;
            date_min)
                date="${cmd[@]:1}"
                ;;
	    focus_changed|window_title_changed)
                windowtitle="${cmd[@]:2}"
                ;;
            quit_panel)
                exit
                ;;
            reload)
                exit
                ;;
        esac
    done
} 2> /dev/null | lemonbar -g ${RES} -u 3 -B ${BG} -F ${FG} -f ${FONT} -f ${FONT2} -f ${FONT3} & $1

