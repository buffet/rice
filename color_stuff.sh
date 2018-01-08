#! /bin/env bash

api=$(curl -sd '{"model":"default"}' http://colormind.io/api/ |
    sed -E 's/.*:\[(.*)\]\}$/\1/' |
    sed -E 's/\],\[/;/g' |
    sed -E 's/\[(.*)\]/\1/')

IFS=';' read -r -a colors <<< "$api"

for color in "${colors[@]}"
do
    echo "$color"
done

