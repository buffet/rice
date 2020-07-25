{ sources ? import ../nix/sources.nix
, stdenv, grim, jq, libnotify, slurp, wl-clipboard }:
stdenv.mkDerivation rec {
  name = "grimshot";
  pname = name;

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
    install -Dm 644 contrib/${pname}.1 $out/share/man/man1/${pname}.1
    install -Dm 755 contrib/${pname} $out/bin/${pname}
  '';

  meta = with stdenv.lib; {
    description = "A helper for screenshots within sway.";
    homepage = "https://gitlab.com/swaywm/sway";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = with maintainers; [ buffet ];
  };
}
