{ config, lib, ... }:
let
  cfg = config.buffet.desktop.alacritty;
in
with lib; {
  options = {
    buffet.desktop.alacritty = {
      enable = mkEnableOption "alacritty";
    };
  };

  config = mkIf cfg.enable {
    buffet.home.programs.alacritty = {
      enable = true;

      settings = {
        window.padding = {
          x = 8;
          y = 8;
        };

        font = {
          family = "GoMono";
          size = 8;
        };

        colors = with config.buffet.desktop.colors; {
          primary = {
            background = primary.background;
            foreground = primary.foreground;
          };

          cursor = {
            cursor = cursor.background;
            text = cursor.foreground;
          };

          normal = {
            black = normal.black;
            red = normal.red;
            green = normal.green;
            yellow = normal.yellow;
            blue = normal.blue;
            magenta = normal.magenta;
            cyan = normal.cyan;
            white = normal.white;
          };

          bright = {
            black = bright.black;
            red = bright.red;
            green = bright.green;
            yellow = bright.yellow;
            blue = bright.blue;
            magenta = bright.magenta;
            cyan = bright.cyan;
            white = bright.white;
          };
        };
      };
    };
  };
}
