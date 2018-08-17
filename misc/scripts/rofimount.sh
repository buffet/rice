#! /bin/sh

pgrep -x rofi && exit 1

mountable="$(lsblk -lp | grep 'part $' | awk '{print $1, "(" $4 ")"}')"
