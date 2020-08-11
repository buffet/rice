{ sources ? import ../nix/sources.nix
, stdenv, grim, jq, libnotify, slurp, wl-clipboard }:
stdenv.mkDerivation rec {
  name = "grimshot";

  src = sources.sway;

  buildInputs = [
    grim
    jq
    libnotify
    slurp
    wl-clipboard
  ];

  dontBuild = true;

  installPhase = ''
    install -Dm 644 contrib/grimshot.1 $out/share/man/man1/grimshot.1
    install -Dm 755 contrib/grimshot $out/bin/grimshot

    sed -i -e 's|grim|${grim}/bin/grim|g' \
           -e 's|jq|${jq}/bin/jq|g' \
           -e 's|notify-send|${libnotify}/bin/notify-send|g' \
           -e 's|slurp|${slurp}/bin/slurp|g' \
           -e 's|wl-copy|${wl-clipboard}/bin/wl-copy|g' \
        $out/bin/grimshot
  '';

  meta = with stdenv.lib; {
    description = "A helper for screenshots within sway";
    homepage = "https://gitlab.com/swaywm/sway";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = with maintainers; [ buffet ];
  };
}
