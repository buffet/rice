{ config, lib, pkgs, ... }:
let
  cfg = config.buffet.desktop.xmonad;
  colors = config.buffet.desktop.colors;
in
  with lib; {
    options = {
      buffet.desktop.xmonad = {
        enable = mkEnableOption "XMonad window manager";
      };
    };

    config = mkIf cfg.enable {
      buffet.home = {
        xsession.windowManager.xmonad = {
          enable = true;
          enableContribAndExtras = true;
          config = let
            xmobarrc = pkgs.writeText "xmobarrc" (import ./xmobarrc.nix { inherit colors; });
          in
            pkgs.writeText "xmonad.hs" (import ./xmonadhs.nix { inherit pkgs colors xmobarrc; });
        };
      };
    };
  }
