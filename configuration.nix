{ pkgs, ... }:
{
  imports = [
    ./machines/current
    ./modules
    ./users.nix
  ];

  nix = {
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  nixpkgs.overlays = [ (import ./overlay) ];

  environment.systemPackages = with pkgs; [
    git
    kakoune
  ];

  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "20.03";
}
