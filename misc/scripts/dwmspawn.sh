#!/usr/bin/env bash

while xsetroot -name "$(date | cut -d' ' -f 4) $(acpi | cut -d' ' -f 4 | head -c -2)"
do
	sleep 1
done &

xsetroot -solid \#1d1f21

exec dwm
