{ config, pkgs, ... }:

let
  extraConf = ./extraConf;
in {
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  home = {
    file.".config/kak/kakrc".source = "${extraConf}/kakoune/kakrc";
    file.".config/kak-lsp/kak-lsp.toml".source = "${extraConf}/kakoune/kak-lsp.toml";
    file.".config/readline/inputrc".source = "${extraConf}/readline/inputrc";
    file.".config/sway/config".source = "${extraConf}/sway/config";
    file.".config/zathura/zathurarc".source = "${extraConf}/zathura/zathurarc";
    file.".direnvrc".source = "${extraConf}/direnv/direnvrc";
    file.".emacs.d/config.org".source = "${extraConf}/emacs/config.org";
    file.".emacs.d/init.el".source = "${extraConf}/emacs/init.el";

    packages = with pkgs; [
      bear
      clang
      clang-tools
      cppcheck
      direnv
      emacs
      fd
      fzf
      gdb
      grim
      htop
      irony-server
      kak-lsp
      kakoune
      llvmPackages.libclang
      mupdf
      neofetch
      ripgrep
      slurp
      texlive.combined.scheme-full
      tree
      wl-clipboard
      zathura
    ];

    sessionVariables = {
      BROWSER = "firefox";
      EDITOR = "kak";
      INPUTRC = "$HOME/.config/readline/inputrc";
      LESSHISTFILE = "$HOME/.cache/less_history";
      XDG_CONFIG_DIR = "$HOME/.config";
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

        t() {
            if [[ $1 ]]; then
                mkdir -p "/tmp/$1"
            fi

            cd "/tmp/$1"
        }

        k() {
            local session repo
            repo="$(git rev-parse --show-toplevel 2>/dev/null)"

            if [[ $? -eq 0 ]]; then
                session="$repo"
            else
                session="$PWD"
            fi

            session="$(basename "$session")"

            if ! kak -l | grep -q "$session"; then
                kak -d -s "$session"
            fi

            kak -c "$session" "$@"
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
        htop = "htop -t";
        mkdir = "mkdir -p";
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

    firefox = {
      enable = true;
      package = pkgs.firefox-wayland;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        darkreader
        https-everywhere
        reddit-enhancement-suite
        vimium
        reddit-moderator-toolbox
        ublock-origin
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
