#!/usr/bin/env bash

notify-send "$(acpi | cut -d' ' -f 4 | head -c -2)"
