#! /bin/env bash

pandoc $1 -o $2
pkill -HUP mupdf

