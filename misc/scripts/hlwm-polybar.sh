#! /bin/env bash

output=$(herbstclient tag_status | sed 's/[^.:#]//g')
