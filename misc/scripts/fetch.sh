#!/bin/sh

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

neofetch --config "${SCRIPTPATH}/nfconfig"
