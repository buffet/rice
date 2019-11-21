{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./programs/sway.nix
    "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos"
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    tmpOnTmpfs = true;
  };

  networking = {
    useDHCP = false;
    interfaces = {
      enp0s25.useDHCP = true;
      wlp3s0.useDHCP = true;
    };
    hostName = "fanya";
    networkmanager.enable = true;
    nameservers = [ "1.1.1.1" ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  time.timeZone = "UTC";

  environment.binsh = "${pkgs.dash}/bin/dash";

  environment.systemPackages = with pkgs; [
    acpi
    brightnessctl
    git
    neovim
  ];

  fonts.fonts = with pkgs; [
    dejavu_fonts
    source-code-pro
  ];

  sound.enable = true;
  systemd.coredump.enable = true;

  hardware = {
    brightnessctl.enable = true;
    opengl.enable = true;
    pulseaudio.enable = true;
  };

  services = {
    emacs = {
      enable = true;
      defaultEditor = true;
    };

    interception-tools.enable = true;

    tlp.enable = true;
    upower.enable = true;
  };

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  users.extraUsers.buffet = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "sway"];
    uid = 1000;
    password = "foo";
  };

  home-manager.users.buffet = import ./home.nix;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?
}
