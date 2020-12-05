{ config, lib, ... }:
let
  cfg = config.buffet.programs;
in
  with lib; {
    imports = [
      ./bash.nix
      ./direnv
      ./emacs
      ./git.nix
      ./kak
      ./tmux.nix
      ./vim
    ];

    options = {
      buffet.programs = {
        extraPackages = mkOption {
          default = [];
          type = types.listOf types.package;
          description = ''
            Extra packages to install on the system.
          '';
        };
      };
    };

    config = {
      buffet.home = {
        home.packages = cfg.extraPackages;
      };
    };
  }
