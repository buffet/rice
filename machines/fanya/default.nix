{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
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

  nix = {
    distributedBuilds = true;

    buildMachines = [{
      hostName = "buffet.sh";
      system = "x86_64-linux";
      sshUser = "buffet";
      sshKey = "/home/buffet/.ssh/id_rsa";
    }];

    extraOptions = ''
      builders-use-substitutes = true
    '';
  };

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  services = {
    tlp.enable = true;
    upower.enable = true;
  };

  systemd.coredump.enable = true;

  buffet = {
    desktop = {
      enable = true;
      colors = import ../../modules/desktop/colors/solarized-light.nix;
      session = "sway";
    };

    programs = {
      bash.enable = true;
      direnv.enable = true;
      git.enable = true;
      kak.enable = true;

      extraPackages = with pkgs; [
        gdb
        htop
        ripgrep
        texlive.combined.scheme-full
        tree
        wget
      ];
    };
  };
}
