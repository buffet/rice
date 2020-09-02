{ config, lib, pkgs, ... }:
let
  cfg = config.buffet.desktop;
in
  with lib; {
    imports = [
      ./alacritty.nix
      ./colors
      ./firefox.nix
      ./sway.nix
      ./zathura.nix
    ];

    options = {
      buffet.desktop = {
        enable = mkEnableOption "graphical session";

        session = mkOption {
          default = "sway";
          type = types.enum [ "sway" ];
          description = ''
            The graphical session used on this system.
          '';
        };
      };
    };

    config = mkIf cfg.enable {
      buffet.desktop = {
        sway.enable = cfg.session == "sway";

        alacritty.enable = true;
        firefox.enable = true;
        zathura.enable = true;
      };

      buffet.home.home.packages = [ pkgs.wl-clipboard ];

      fonts.fonts = with pkgs; [
        dejavu_fonts
        go-font
      ];

      sound.enable = true;
      hardware.pulseaudio.enable = true;
    };
  }
