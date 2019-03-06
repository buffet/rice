{ config, pkgs, ... }:

let
  extraConf = ./extraConf;
in {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.overlays = [
    (import (builtins.fetchTarball https://github.com/buffet/overlay/archive/master.tar.gz))
  ];

  home = {
    file.".config/alacritty/alacritty.yml".source = "${extraConf}/alacritty/alacritty.yml";
    file.".config/sway/config".source = "${extraConf}/sway/config";
    file.".inputrc".source = "${extraConf}/readline/inputrc";

    packages = with pkgs; [
      alacritty
      cherry
      clang-tools
      ctags
      exa
      fd
      filet
      fortune
      fzf
      grim
      htop
      neofetch
      ranger
      ripgrep
      slurp
      wl-clipboard
    ];

    sessionVariables = {
      BROWSER = "chromium";
      CARGO_HOME = "\$HOME/.cache/cargo";
      EDITOR = "nvim";
      LESSHISTFILE = "\$HOME/.cache/less_history";
      XKB_DEFAULT_LAYOUT = "us,dvorak";
      XKB_DEFAULT_OPTIONS = "grp:alt_shift_toggle,compose:ralt";
      XKB_DEFAULT_VARIANT = ",nodeadkeys";
    };
  };

  programs.bash = {
    enable = true;
    enableAutojump = true;
    historyControl = [ "erasedups" "ignorespace" ];
    historyFile = "\$HOME/.cache/bash_history";
    initExtra = ''
      f() {
          filet "$@"
          cd "$(< /tmp/filet_dir)"
      }
      prompt() {
          case $? in
              0) PS1='% ';;
              *) PS1='\[\e[31m\]% \[\e[0m';;
          esac
      }
      PROMPT_COMMAND=prompt
    '';
    shellAliases = {
      def-build = "nix-build -E \"with import <nixpkgs> {}; callPackage ./. {}\"";
      def-shell = "nix-shell -E \"with import <nixpkgs> {}; callPackage ./. {}\"";
      e = "exa";
      eal = "exa -al";
      el = "exa -l";
      htop = "htop -t";
      mkdir = "mkdir -p";
      ra = "ranger";
      t = "cd /tmp";
      v = "nvim";
    };
    shellOptions = [
      "cdspell"
      "checkjobs"
      "extglob"
      "globstar"
      "histappend"
      "nocaseglob"
    ];
  };

  programs.chromium = {
    enable = true;
    extensions = [
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
      "kbmfpngjjgdllneeigpgjifpgocmfgmb" # Reddit Enhancement Suite
      "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
      "jhjpjhhkcbkmgdkahnckfboefnkgghpo" # toolbox
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
    ];
  };

  programs.git = {
    enable = true;
    aliases = {
      b = "!git for-each-ref --sort='-authordate' --format='%(authordate)%09%(objectname:short)%09%(refname)' refs/heads | sed -e 's-refs/heads/--'";
      c = "commit --verbose";
      cm = "commit --verbose -m";
      co = "checkout";
      cob = "checkout -b";
      m = "commit --ammend --verbose";
      s = "status -s";
    };
    extraConfig = ''
      [url "https://github.com/"]
        insteadOf = "gh:"
      [url "https://gitlab.com/"]
        insteadOf = "gl:"
    '';
    userEmail = "niclas@countingsort.com";
    userName = "buffet";
  };

  programs.neovim = {
    enable = true;
    configure = {
      customRC = builtins.readFile "${extraConf}/vim/init.vim";
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
          auto-pairs
          base16-vim
          ctrlp-vim
          emmet-vim
          goyo-vim
          lightline-vim
          limelight-vim
          neoformat
          nerdtree
          supertab
          tabular
          vim-easytags
          zoomwintab-vim
        ];
      };
    };
    vimAlias = true;
  };
}
