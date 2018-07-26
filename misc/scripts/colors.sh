# /bin/env bash

for j in {30..37}
do
	for i in 0 1
	do
		printf "\e[$i;${j}m$i;$j "
	done

	printf "\n"
done

printf "\e[0m"
