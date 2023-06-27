{
  nixpkgs,
  nixpkgs-unstable,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # Don't change!
  system.stateVersion = "22.05";
  home-manager.users.buffet.home.stateVersion = "22.05";

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  #boot.tmpOnTmpfs = true;
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  fileSystems = {
    "/".options = ["compress=zstd"];
    "/nix".options = ["compress=zstd" "noatime"];
    "/persist".options = ["compress=zstd"];
  };

  networking = {
    useDHCP = false;
    interfaces = {
      enp0s25.useDHCP = true;
      wlp3s0.useDHCP = true;
    };
    hostName = "fanya";
    networkmanager.enable = true;
    nameservers = ["1.1.1.1"];
  };

  nix = {
    registry = {
      nixpkgs.flake = nixpkgs;
      nixpkgs-unstable.flake = nixpkgs-unstable;
    };
    settings = {
      auto-optimise-store = true;
      trusted-users = ["root" "buffet"];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
