{ config, lib, pkgs, ... }:
let
  cfg = config.buffet.desktop;
in
  with lib; {
    imports = [
      ./alacritty.nix
      ./colors
      ./firefox
      ./mako.nix
      ./sway.nix
      ./xmonad
      ./xorg.nix
      ./zathura.nix
    ];

    options = {
      buffet.desktop = {
        enable = mkEnableOption "graphical session";

        session = mkOption {
          default = "sway";
          type = types.enum [ "sway" "xmonad" ];
          description = ''
            The graphical session used on this system.
          '';
        };

        sessionType = mkOption {
          type = types.enum [ "wayland" "xorg" ];
          visible = false;
        };
      };
    };

    config = mkIf cfg.enable {
      buffet.desktop = {
        sway.enable = cfg.session == "sway";
        xmonad.enable = cfg.session == "xmonad";

        sessionType =
          if (elem cfg.session [ "sway" ])
          then "wayland"
          else "xorg";

        alacritty.enable = true;
        firefox.enable = true;
        zathura.enable = true;

        mako.enable = cfg.sessionType == "wayland";
        xorg.enable = cfg.sessionType == "xorg";
      };

      buffet.home.home.packages =
        if (cfg.sessionType == "wayland")
        then [ pkgs.wl-clipboard ]
        else [ pkgs.xclip ];

      fonts.fonts = with pkgs; [
        dejavu_fonts
        go-font
      ];

      sound.enable = true;
      hardware.pulseaudio.enable = true;
    };
  }
