#! /bin/env bash

apiaw=$(curl -sd '{"model":"default"}' http://colormind.io/api/ | # get json
    sed -E 's/.*:\[(.*)\]\}$/\1/'                               | # extract array
    sed -E 's/\],\[/;/g'                                        | # make seperated
    sed -E 's/\[(.*)\]/\1/')                                      # remove enclosing []

# to array
IFS=';' read -r -a colors <<< "$apiaw"

for i in "${!colors[@]}"
do
    IFS=',' read -r -a rgb <<< "${colors[$i]}"

    for j in "${!rgb[@]}"
    do
        val="${rgb[$j]}"
        rgb[$j]=$(echo "ibase=10;obase=16;$val" | bc)
    done

    colors["$i"]="#${rgb[0]}${rgb[1]}${rgb[2]}"
done

# background
echo "Background: ${colors[0]}"
xsetroot -solid "${colors[0]}"

# normal window
echo "Normal window border: ${colors[1]}"
bspc config normal_border_color "${colors[1]}"

# focused window
echo "Focused window border: ${colors[2]}"
bspc config focused_border_color "${colors[2]}"

# presel color
echo "Presel color: ${colors[3]}"
bspc config presel_feedback_color "${colors[3]}"

# unused
echo "Unused: ${colors[4]}"

