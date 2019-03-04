{ config, lib, pkgs, ... }:

{
  config.programs.sway-beta = {
    enable = true;
    extraPackages = with pkgs; [
      brightnessctl
      i3status
      swaylock
      xwayland
    ];
  };
}
