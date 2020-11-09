{ config, lib, pkgs, ... }:
let
  cfg = config.buffet.programs.emacs;
  sources = import ../../../nix/sources.nix;
  doom-emacs = pkgs.callPackage sources.nix-doom-emacs {
    doomPrivateDir = ./doom.d;
  };
in
  with lib; {
    options = {
      buffet.programs.emacs = {
        enable = mkEnableOption "emacs";
      };
    };

    config = mkIf cfg.enable {
      services.emacs = {
        enable = true;
        package = doom-emacs;
        defaultEditor = true;
      };

      buffet.home = {
        home = {
          sessionVariables = {
            VISUAL = config.environment.variables.EDITOR;
          };

          packages = with pkgs; [
            fd
            ripgrep
            shellcheck
          ];
        };
      };
    };
  }
