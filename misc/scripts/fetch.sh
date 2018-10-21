#!/bin/sh

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

neofetch --config "${SCRIPTPATH}/nfconfig" | head -n-1
echo "st:$(curl https://api.github.com/repos/buffet/kiwmi 2>/dev/null | grep 'stargazers_count' | cut -d':' -f2 | head -c-2)"
