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

          # TODO: add this to Emacs' env
          packages = with pkgs; [
            clang-tools # lang/cc
            fd
            nixfmt # lang/nix
            ripgrep
            rust-analyzer # lang/rust +lsp
            shellcheck # lang/sh
            texlab # lang/latex +lsp
            texlive.combined.scheme-full # lang/latex
          ];
        };
      };
    };
  }
