{ config, lib, ... }:
let
  cfg = config.buffet.desktop.picom;
in
  with lib; {
    options = {
      buffet.desktop.picom = {
        enable = mkEnableOption "picom";
      };
    };

    config = mkIf cfg.enable {
      buffet.home = {
        services.picom = {
          enable = true;
          fade = true;
          fadeDelta = 1;
          inactiveDim = "0.02";
          shadow = true;
          shadowOpacity = "0.2";
          vSync = true;
        };
      };
    };
  }
