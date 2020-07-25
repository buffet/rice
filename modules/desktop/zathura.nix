{ config, lib, ... }:
let
  cfg = config.buffet.desktop.zathura;
in
with lib; {
  options = {
    buffet.desktop.zathura = {
      enable = mkEnableOption "zathura";
    };
  };

  config = mkIf cfg.enable {
    buffet.home = {
      programs.zathura = {
        enable = true;

        options = {
          guioptions = "";
          recolor = true;
          recolor-darkcolor = config.buffet.desktop.colors.primary.foreground;
          recolor-lightcolor = config.buffet.desktop.colors.primary.background;
        };
      };
    };
  };
}
