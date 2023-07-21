{lib, ...}: {
  home-manager.users.buffet = {
    programs.foot = {
      enable = true;
      server.enable = true;

      settings = let
        theme = import ../theme.nix;
        dehash = lib.attrsets.mapAttrs (_: lib.strings.removePrefix "#");
        normal = dehash theme.normal;
        bright = dehash theme.bright;
      in {
        main = {
          font = "${theme.font.family}:size=${toString (theme.font.size - 2)}";
          #font-italic = "${theme.font.family}:size=${toString (theme.font.size - 2)}";
          #font-bold-italic = "${theme.font.family}:style=Bold:size=${toString (theme.font.size - 2)}";
          pad = "${toString theme.font.size}x${toString theme.font.size}";
        };

        scrollback.lines = 10000;

        url = {
          launch = ''firefox ''${url}'';
        };

        key-bindings = {
          show-urls-launch = "Control+Shift+l";
        };

        colors = {
          foreground = lib.strings.removePrefix "#" theme.primary.foreground;
          background = lib.strings.removePrefix "#" theme.primary.background;

          regular0 = normal.black;
          regular1 = normal.red;
          regular2 = normal.green;
          regular3 = normal.yellow;
          regular4 = normal.blue;
          regular5 = normal.magenta;
          regular6 = normal.cyan;
          regular7 = normal.white;

          bright0 = bright.black;
          bright1 = bright.red;
          bright2 = bright.green;
          bright3 = bright.yellow;
          bright4 = bright.blue;
          bright5 = bright.magenta;
          bright6 = bright.cyan;
          bright7 = bright.white;
        };
      };
    };
  };
}
