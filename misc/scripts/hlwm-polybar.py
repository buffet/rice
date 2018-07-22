#! /bin/env python3

import os

cmd = 'herbstclient tag_status'
wstr = ''
output = list(filter(lambda c: c in '.#:', os.popen(cmd).read()))

#output.append(output.pop(0))

for i, c in enumerate(output):
    if c == ':':
        wstr += str((i+1) % 10)
    elif c == '.':
        wstr += str((i+1) % 10)
    elif c == '#':
        wstr += '#'

print(wstr)
