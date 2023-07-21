{pkgs, ...}: {
  imports = [
    ./programs/bash.nix
    ./programs/borg.nix
    ./programs/cargo.nix
    ./programs/firefox.nix
    ./programs/foot.nix
    ./programs/git.nix
    ./programs/gpg.nix
    ./programs/ime.nix
    ./programs/keyd.nix
    ./programs/lsd.nix
    ./programs/mako.nix
    ./programs/newsboat.nix
    ./programs/nvim.nix
    ./programs/pipewire.nix
    ./programs/sbcl.nix
    ./programs/sioyek.nix
    ./programs/sway.nix
  ];

  environment.systemPackages = with pkgs; [
    gitFull
    neovim
  ];

  fonts.fonts = with pkgs; [
    apl386
    dejavu_fonts
    noto-fonts
    noto-fonts-cjk
  ];

  home-manager.users.buffet = {
    home = {
      sessionVariables = {
        ANKI_WAYLAND = 1;
      };

      packages = with pkgs; [
        unstable.anki

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
        rustfmt
        strace
        tokei
        trash-cli
        tree
        valgrind
        wget
        wl-clipboard

        (luajit.withPackages (ps:
          with ps; [
            fennel
            inspect
            luv
          ]))

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
  };

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
    earlyoom = {
      enable = true;
      enableNotifications = true;
    };

    upower.enable = true;
    systembus-notify.enable = true;
  };
}
