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

    buildMachines = [
      {
        hostName = "buffet.sh";
        system = "x86_64-linux";
        sshUser = "buffet";
        sshKey = "/home/buffet/.ssh/id_rsa";
      }
    ];

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

    borgbackup = {
      jobs.backup = {
        paths = [ "/etc" "/home" "/root" "/var" ];
        repo = "borg@buffet.sh:./fanya";
        encryption.mode = "none"; # TODO: encrypt
        startAt = "daily";
        environment.BORG_RSH = "ssh -i /home/buffet/.ssh/id_rsa";
        prune.keep = {
          within = "1d";
          daily = 7;
          weekly = 4;
          monthly = -1;
        };
      };
    };
  };

  systemd.coredump.enable = true;

  systemd.timers.borgbackup-job-backup.timerConfig.Persistent = true;

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
        cloc
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
