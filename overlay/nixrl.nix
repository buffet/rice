{ writeScriptBin }:
writeScriptBin "nixrl" ''
  #!/bin/sh

  config="''${NIXOS_CONFIG:-/etc/nixos}"

  action="''${1:-switch}"
  machine="$config/machines/''${2:-$HOSTNAME}"

  if ! [ -d "$machine" ]; then
      >&2 printf %s "$machine not found"
      exit 1
  fi

  nixos-rebuild -I machine="$machine" "$action"
''
