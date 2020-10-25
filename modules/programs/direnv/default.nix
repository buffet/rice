{ config, lib, ... }:
let
  cfg = config.buffet.programs.direnv;
in
  with lib; {
    options = {
      buffet.programs.direnv = {
        enable = mkEnableOption "direnv";
      };
    };

    config = mkIf cfg.enable {
      buffet.home = {
        programs.direnv = {
          enable = true;
          enableBashIntegration = true;
        };

        xdg.configFile."direnv/direnvrc".source = ./direnvrc;
      };
    };
  }
