{ config, lib, ... }:
let
  cfg = config.buffet.programs.git;
in
with lib; {
  options = {
    buffet.programs.git = {
      enable = mkEnableOption "git";
    };
  };

  config = mkIf cfg.enable {
    buffet.home = {
      programs.git = {
        enable = true;
        userEmail = "niclas@countingsort.com";
        userName = "buffet";

        aliases = {
          c = "commit --verbose";
          co = "checkout";
          cob = "checkout -b";
          m = "commit --ammend --verbose";
          s = "status -s";
        };
      };
    };
  };
}
