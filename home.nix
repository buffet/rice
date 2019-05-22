{ config, pkgs, ... }:

let
  extraConf = ./extraConf;
in {
  home = {
    file.".config/alacritty/alacritty.yml".source = "${extraConf}/alacritty/alacritty.yml";
    file.".config/readline/inputrc".source = "${extraConf}/readline/inputrc";
    file.".config/sway/config".source = "${extraConf}/sway/config";
    file.".emacs.d/config.org".source = "${extraConf}/emacs/config.org";
    file.".emacs.d/init.el".source = "${extraConf}/emacs/init.el";

    packages = with pkgs; [
      alacritty
      bear
      cherry
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
                0) PS1='%' ;;
                *) PS1='\[\e[31m\]%' ;;
            esac

            [[ $IN_NIX_SHELL ]] && PS1+="'"

            PS1+='\[\e[0m\] '
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
      extraConfig = ''
        [url "https://github.com/"]
          insteadOf = "gh:"
        [url "https://gitlab.com/"]
          insteadOf = "gl:"
      '';
      userEmail = "niclas@countingsort.com";
      userName = "buffet";
    };

    neovim = {
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
  };
}
