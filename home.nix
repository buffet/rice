{ config, pkgs, ... }:

let
  extraConf = ./extraConf;
in {
  home = {
    file.".config/readline/inputrc".source = "${extraConf}/readline/inputrc";
    file.".config/sway/config".source = "${extraConf}/sway/config";
    file.".direnvrc".source = "${extraConf}/direnv/direnvrc";
    file.".emacs.d/config.org".source = "${extraConf}/emacs/config.org";
    file.".emacs.d/init.el".source = "${extraConf}/emacs/init.el";

    packages = with pkgs; [
      alacritty
      bear
      clang
      clang-tools
      cppcheck
      direnv
      emacs
      exa
      fd
      filet
      fortune
      fzf
      grim
      htop
      irony-server
      llvmPackages.libclang
      mupdf
      neofetch
      ranger
      ripgrep
      slurp
      texlive.combined.scheme-full
      wl-clipboard
      zathura
    ];

    sessionVariables = {
      BROWSER = "chromium";
      CARGO_HOME = "$HOME/.cache/cargo";
      INPUTRC = "$HOME/.config/readline/inputrc";
      LESSHISTFILE = "$HOME/.cache/less_history";
    };
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    alacritty = {
      enable = true;
      settings = {
        window = {
          padding.x = 8;
          padding.y = 8;
        };

        font = {
          family = "GoMono";
          size = 11.5;
        };

        colors = {
          primary = {
            background = "0x2e3440";
            foreground = "0xd8dee9";
          };
          cursor = {
            text = "0x2e3440";
            cursor = "0xd8dee9";
          };
          normal = {
            black = "0x3b4252";
            red = "0xbf616a";
            green = "0xa3be8c";
            yellow = "0xebcb8b";
            blue = "0x81a1c1";
            magenta = "0xb48ead";
            cyan = "0x88c0d0";
            white = "0xe5e9f0";
          };
          bright = {
            black = "0x4c566a";
            red = "0xbf616a";
            green = "0xa3be8c";
            yellow = "0xebcb8b";
            blue = "0x81a1c1";
            magenta = "0xb48ead";
            cyan = "0x8fbcbb";
            white = "0xeceff4";
          };
        };
      };
    };

    bash = {
      enable = true;
      enableAutojump = true;
      historyControl = [ "erasedups" "ignorespace" ];
      historyFile = "\$HOME/.cache/bash_history";
      initExtra = ''
        export TERM=xterm-256color

        f() {
            filet "$@"
            cd "$(< /tmp/filet_dir)"
        }

        t() {
            if [[ $1 ]]; then
                mkdir -p "/tmp/$1"
            fi

            cd "/tmp/$1"
        }

        prompt() {
            case $? in
                0) PS1='\[\e[36m\]>> \[\e[0m\]' ;;
                *) PS1='\[\e[31m\]>> \[\e[0m\]' ;;
            esac
        }
        PROMPT_COMMAND=prompt

        eval "$(direnv hook bash)"
      '';
      shellAliases = {
        def-build = "nix-build -E \"with import <nixpkgs> {}; callPackage ./. {}\"";
        def-shell = "nix-shell -E \"with import <nixpkgs> {}; callPackage ./. {}\"";
        e = "exa";
        eal = "exa -al";
        el = "exa -l";
        em = "emacs";
        htop = "htop -t";
        mkdir = "mkdir -p";
        ra = "ranger";
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

    chromium = {
      enable = true;
      extensions = [
        "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
        "gcbommkclmclpchllfjekcdonpmejbdp" # HTTPS Everywhere
        "kbmfpngjjgdllneeigpgjifpgocmfgmb" # Reddit Enhancement Suite
        "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
        "jhjpjhhkcbkmgdkahnckfboefnkgghpo" # toolbox
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
      ];
    };

    git = {
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
      userEmail = "niclas@countingsort.com";
      userName = "buffet";
    };
  };
}
