{
  pkgs,
  home-manager,
  ...
}: let
  password = "$6$FHwMlUwmRdAsPqS4$4XND0L0EEVf2Mhc/tvo6y3ZLIrMTOlsIZrG3w69EeXvtVZhdeNyoDOkPNIe.GBB8.PrchuUKDacqbvcvyuPkt0";
in {
  imports = [
    home-manager.nixosModule
    ./impermanence.nix
    ./programs
    ./system.nix
  ];

  # TODO: setup phinger-cursors

  environment.systemPackages = with pkgs; [
    git
    neovim
  ];

  fonts.fonts = with pkgs; [
    dejavu_fonts
    go-font
    noto-fonts
  ];

  home-manager.users.buffet = {
    home.packages = with pkgs; [
      du-dust
      fd
      gdb
      github-cli
      htop
      kcachegrind
      linuxPackages.perf
      okular
      radare2
      ripgrep
      scc
      strace
      trash-cli
      tree
      valgrind
      wget
      wl-clipboard
    ];

    home.sessionVariables = {
      BROWSER = "chromium";
    };

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableBashIntegration = true;
    };
  };

  users.users.buffet = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [
      "networkmanager"
      "sway"
      "wheel"
    ];
    hashedPassword = password;
  };

  users.users.root.hashedPassword = password;

  # TODO: borgbackup
  hardware.bluetooth.enable = true;
  virtualisation.libvirtd.enable = true;
  systemd.coredump.enable = true;

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  services = {
    tlp.enable = true;
    upower.enable = true;
  };
}
