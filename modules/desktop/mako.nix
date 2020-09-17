{ config, lib, pkgs, ... }:
let
  cfg = config.buffet.desktop.mako;
  colors = config.buffet.desktop.colors;
in
  with lib; {
    options = {
      buffet.desktop.mako = {
        enable = mkEnableOption "mako notification daemon";
      };
    };

    config = mkIf cfg.enable {
      buffet.home = {
        home.packages = [ pkgs.libnotify ];

        programs.mako = {
          enable = true;

          anchor = "top-right";

          backgroundColor = colors.primary.background;
          borderColor = colors.wm.focused.border;
          progressColor = colors.primary.foreground;
          textColor = colors.primary.foreground;
          borderSize = 1;

          defaultTimeout = 4000;

          font = "GoMono 9";
        };
      };
    };
  }
