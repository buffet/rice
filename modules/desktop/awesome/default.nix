{ config, lib, pkgs, ... }:
let
  cfg = config.buffet.desktop.awesome;
in
  with lib; {
    options = {
      buffet.desktop.awesome = {
        enable = mkEnableOption "awesome window manager";
      };
    };

    config = mkIf cfg.enable {
      buffet.home = {
        xsession.windowManager.awesome.enable = true;
      };

      services.xserver.windowManager.awesome.enable = true;
    };
  }
