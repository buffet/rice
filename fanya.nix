{
  pkgs,
  home-manager,
  ...
}: {
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
    initialPassword = "foo";
  };

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
