{ sources ? import ../nix/sources.nix
, stdenv, makeWrapper, grim, jq, libnotify, slurp, wl-clipboard }:
stdenv.mkDerivation rec {
  name = "grimshot";

  src = sources.sway;

  nativeBuildInputs = [
    makeWrapper
  ];

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
  '';

  postFixup = ''
    wrapProgram $out/bin/grimshot \
        --prefix PATH : ${stdenv.lib.makeBinPath [ grim jq libnotify slurp wl-clipboard ]}
  '';

  meta = with stdenv.lib; {
    description = "A helper for screenshots within sway";
    homepage = "https://gitlab.com/swaywm/sway";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = with maintainers; [ buffet ];
  };
}
