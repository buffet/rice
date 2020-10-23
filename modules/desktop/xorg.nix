{ config, lib, ... }:
let
  cfg = config.buffet.desktop.xorg;
in
  with lib; {
    options = {
      buffet.desktop.xorg = {
        enable = mkEnableOption "Xorg display server";
      };
    };

    config = mkIf cfg.enable {
      buffet.home = {
        home.file.".xprofile".text = ''
          [ -f ~/.profile ] && . ~/.profile
        '';
      };

      services.xserver = {
        enable = true;
        libinput.enable = true;
        windowManager.xmonad.enable = config.buffet.desktop.xmonad.enable;
      };
    };
  }
