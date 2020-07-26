{ pkgs, ... }:
let
  sources = import ./nix/sources.nix;
in
{
  imports = [
    ./machines/current
    ./modules
    ./users.nix
  ];

  nix = {
    autoOptimiseStore = true;
    trustedUsers = [ "root" "buffet" ];

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  nixpkgs = {
    overlays = [ (import ./overlay) ];
    pkgs = import sources.nixpkgs { };
  };

  environment.systemPackages = with pkgs; [
    git
    kakoune
    niv
  ];

  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "20.03";
}
