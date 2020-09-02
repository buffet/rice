{ config, lib, ... }:
let
  cfg = config.buffet.desktop.colors;
in
  with lib; {
    options = {
      buffet.desktop.colors = {
        primary = {
          background = mkOption { type = types.str; };
          foreground = mkOption { type = types.str; };
        };

        cursor = {
          background = mkOption { type = types.str; };
          foreground = mkOption { type = types.str; };
        };

        normal = {
          black = mkOption { type = types.str; };
          red = mkOption { type = types.str; };
          green = mkOption { type = types.str; };
          yellow = mkOption { type = types.str; };
          blue = mkOption { type = types.str; };
          magenta = mkOption { type = types.str; };
          cyan = mkOption { type = types.str; };
          white = mkOption { type = types.str; };
        };

        bright = {
          black = mkOption { type = types.str; };
          red = mkOption { type = types.str; };
          green = mkOption { type = types.str; };
          yellow = mkOption { type = types.str; };
          blue = mkOption { type = types.str; };
          magenta = mkOption { type = types.str; };
          cyan = mkOption { type = types.str; };
          white = mkOption { type = types.str; };
        };

        wm = {
          focused = {
            text = mkOption { type = types.str; };
            border = mkOption { type = types.str; };
          };

          unfocused = {
            text = mkOption { type = types.str; };
            border = mkOption { type = types.str; };
          };
        };
      };
    };
  }
