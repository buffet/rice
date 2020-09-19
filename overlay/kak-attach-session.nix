{ writeScriptBin }:
writeScriptBin "kak-attach-session" ''
  #!/bin/sh

  kak -clear

  repo="$(git rev-parse --show-toplevel 2>/dev/null)"


  if [ $? -eq 0 ]; then
      session="$repo"
  else
      session="$PWD"
  fi

  session="''${session##*/}"

  if ! kak -l | grep -q "$session"; then
      kak -d -s "$session"
  fi

  kak -c "$session" "$@"
''
