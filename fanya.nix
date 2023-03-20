{
  pkgs,
  agenix,
  home-manager,
  nur,
  ...
}: let
  password = "$6$FHwMlUwmRdAsPqS4$4XND0L0EEVf2Mhc/tvo6y3ZLIrMTOlsIZrG3w69EeXvtVZhdeNyoDOkPNIe.GBB8.PrchuUKDacqbvcvyuPkt0";
in {
  imports = [
    agenix.nixosModules.default
    home-manager.nixosModule
    nur.nixosModules.nur
    ./impermanence.nix
    ./programs
    ./system.nix
  ];

  environment.systemPackages = with pkgs; [
    gitFull
    neovim
  ];

  fonts.fonts = with pkgs; [
    (nerdfonts.override {fonts = ["Go-Mono"];})
    apl386
    dejavu_fonts
    noto-fonts
  ];

  home-manager.users.buffet = {
    home = {
      packages = with pkgs; [
        cargo
        cargo-crev
        cargo-limit
        cargo-nextest
        du-dust
        fd
        gdb
        github-cli
        htop
        hyperfine
        jq
        kcachegrind
        linuxPackages.perf
        man-pages
        man-pages-posix
        okular
        radare2
        ripgrep
        rr
        strace
        tokei
        trash-cli
        tree
        valgrind
        wget
        wl-clipboard

        (retroarch.override {
          cores = with libretro; [
            genesis-plus-gx
          ];
        })
      ];

      pointerCursor = {
        package = pkgs.phinger-cursors;
        name = "phinger-cursors-light";
        gtk.enable = true;
      };
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
      "docker"
      "networkmanager"
      "sway"
      "uinput"
      "wheel"
    ];
    hashedPassword = password;
  };

  users.users.root.hashedPassword = password;

  systemd.coredump.enable = true;

  hardware = {
    bluetooth.enable = true;
    uinput.enable = true;
  };

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  services = {
    tlp.enable = true;
    upower.enable = true;
  };
}
