{ config, lib, pkgs, ... }:
let
  cfg = config.buffet.desktop.dunst;
  colors = config.buffet.desktop.colors;
in
  with lib; {
    options = {
      buffet.desktop.dunst = {
        enable = mkEnableOption "dunst notification daemon";
      };
    };

    config = mkIf cfg.enable {
      buffet.home = {
        home.packages = [ pkgs.libnotify ];

        services.dunst = {
          #enable = true;

          # TODO: port mako config
          settings = {};
        };
      };
    };
  }
