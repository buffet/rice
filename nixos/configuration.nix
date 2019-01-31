{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./programs/sway.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    tmpOnTmpfs = true;
  };

  networking = {
    hostName = "lola";
    networkmanager.enable = true;
    nameservers = [ "1.1.1.1" ];
  };

  time.timeZone = "Europe/Berlin";

  environment.systemPackages = with pkgs; [
    acpi
    git
    neovim
  ];

  fonts.fonts = with pkgs; [
    dejavu_fonts
  ];

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.opengl.enable = true;

  services.xserver = {
    enable = true;
    libinput.enable = true;
  };

  users.extraUsers.buffet = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "sway"];
    shell = pkgs.zsh;
    uid = 1000;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?
}
