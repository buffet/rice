{ config, lib, pkgs, ... }:

{
  config.programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      i3status
      swaylock
      xwayland
    ];
  };
}
