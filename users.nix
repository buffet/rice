{ config, lib, options, ... }:
let
  sources = import ./nix/sources.nix;
  home-manager = "${sources.home-manager}/nixos";
in
{
  imports = [
    home-manager
  ];

  users.users.buffet = {
    isNormalUser = true;
    extraGroups = [ "wheel" "sway" "networkmanager" "rclone" "dialout" ];
    uid = config.buffet.ids.uids.buffet;
    openssh.authorizedKeys.keys = import ./keys.nix;
  };

  home-manager.useGlobalPkgs = true;
  home-manager.users.buffet = lib.mkAliasDefinitions options.buffet.home;
}
