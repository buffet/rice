{ config, lib, pkgs, ...}:

{
  config.programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      brightnessctl
      xwayland
    ];
  };
}
