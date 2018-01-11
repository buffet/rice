#! /bin/env bash

apiaw=$(curl -sd '{"model":"ui"}' http://colormind.io/api/ | # get json
    sed -E 's/.*:\[\[(.*)\]\]\}$/\1/'                      | # extract array
    sed -E 's/\],\[/;/g')                                    # make seperated

# to array
IFS=';' read -r -a colors <<< "$apiaw"

for i in "${!colors[@]}"
do
    IFS=',' read -r -a rgb <<< "${colors[$i]}"

    for j in "${!rgb[@]}"
    do
        val="${rgb[$j]}"
        rgb[$j]=$(printf "%02x" "$val")
    done

    colors["$i"]="#${rgb[0]}${rgb[1]}${rgb[2]}"
done

# background
echo "Background: ${colors[4]}"
xsetroot -solid "${colors[4]}"

# normal window
echo "Normal window border: ${colors[3]}"
bspc config normal_border_color "${colors[3]}"

# focused window
echo "Focused window border: ${colors[1]}"
bspc config focused_border_color "${colors[1]}"

# presel color
echo "Presel color: ${colors[0]}"
bspc config presel_feedback_color "${colors[0]}"

# unused
echo "Unused: ${colors[2]}"

