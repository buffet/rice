{ config, lib, ... }:
let
  cfg = config.buffet.programs.tmux;
in
  with lib; {
    options = {
      buffet.programs.tmux = {
        enable = mkEnableOption "tmux";
      };
    };

    config = mkIf cfg.enable {
      buffet.home = {
        programs.tmux = {
          enable = true;
          customPaneNavigationAndResize = true;
          escapeTime = 0;
          keyMode = "vi";
          shortcut = "a";
        };
      };
    };
  }
