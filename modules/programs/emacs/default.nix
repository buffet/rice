{ config, lib, pkgs, ... }:
let
  cfg = config.buffet.programs.emacs;
  sources = import ../../../nix/sources.nix;
  doom-emacs = pkgs.callPackage sources.nix-doom-emacs;
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
        defaultEditor = true;

        package = doom-emacs {
          doomPrivateDir = ./doom.d;
        };
      };

      buffet.home = {
        home.sessionVariables = {
          VISUAL = config.environment.variables.EDITOR;
        };

        home.packages = with pkgs; [
            clang-tools # lang/cc +lsp
            fd
            gitAndTools.gitflow # tools/magit
            luajitPackages.moonscript # lang/lua +moonscript
            nixfmt # lang/nix
            python37Packages.python-language-server # lang/python +lsp
            ripgrep
            rust-analyzer # lang/rust +lsp
            shellcheck # lang/sh
            texlab # lang/latex +lsp
            texlive.combined.scheme-full # lang/latex
        ];
      };
    };
  }
