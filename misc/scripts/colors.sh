# /bin/env bash

for  ((i=0; i<8; i++)); do
	echo -en "\e[48;5;${i}m   \e[0m "
done

printf "\n"

for  ((i=8; i<16; i++)); do
	echo -en "\e[48;5;${i}m   \e[0m "
done

printf "\n"
