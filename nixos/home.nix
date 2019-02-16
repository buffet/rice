{ config, pkgs, ... }:

let
  dotdir = /home/buffet/dotfiles;
  aliases = {
    def-build = "nix-build -E \"with import <nixpkgs> {}; callPackage ./. {}\"";
    def-shell = "nix-shell -E \"with import <nixpkgs> {}; callPackage ./. {}\" --pure";
    e = "exa";
    eal = "exa -al";
    el = "exa -l";
    mkdir = "mkdir -p";
    ra = "ranger";
    ta = "tmux attach-session -t";
    tkill = "tmux kill-session -t";
    tls = "tmux list-sessions";
    tm = "tmux";
    tnew = "tmux new -s";
    v = "nvim";
  };
in {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = {
    file.".config/alacritty/alacritty.yml".source = "${dotdir}/alacritty/alacritty.yml";
    file.".config/sway/config".source = "${dotdir}/sway/config";
    file.".inputrc".source = "${dotdir}/readline/inputrc";

    packages = with pkgs; [
      alacritty
      exa
      fd
      fortune
      fzf
      htop
      neofetch
      ranger
      ripgrep
    ];

    sessionVariables = {
      BROWSER = "chromium";
      EDITOR = "nvim";
      LESSHISTFILE = "\$HOME/.local/share/less/history";
      XKB_DEFAULT_LAYOUT = "us,dvorak";
      XKB_DEFAULT_OPTIONS = "grp:alt_shift_toggle,compose:ralt";
      XKB_DEFAULT_VARIANT = ",nodeadkeys";
    };
  };

  programs.bash = {
    enable = true;
    enableAutojump = true;
    historyControl = [ "erasedups" "ignorespace" ];
    historyFile = "\$HOME/.local/share/bash/history";
    initExtra = ''
      prompt() {
          if [[ $? -eq 0 ]]; then
            color="\e[0;34m"
          else
            color="\e[0;31m"
          fi
          PS1="[''${color}\W\e[0m] "
      }
      PROMPT_COMMAND=prompt
    '';
    shellAliases = aliases;
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

  programs.tmux = {
    enable = true;
    extraConfig = ''
      # New prefix
      set -g prefix C-a
      unbind C-b
      bind-key C-a send-prefix

      # Smart pane switching with awareness of Vim splits.
      # See: https://github.com/christoomey/vim-tmux-navigator
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
      | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
      bind-key -n C-h if-shell "$is_vim" "send-keys C-h"  "select-pane -L"
      bind-key -n C-j if-shell "$is_vim" "send-keys C-j"  "select-pane -D"
      bind-key -n C-k if-shell "$is_vim" "send-keys C-k"  "select-pane -U"
      bind-key -n C-l if-shell "$is_vim" "send-keys C-l"  "select-pane -R"
      bind-key -n C-\ if-shell "$is_vim" "send-keys C-\\" "select-pane -l"
      bind-key -T copy-mode-vi C-h select-pane -L
      bind-key -T copy-mode-vi C-j select-pane -D
      bind-key -T copy-mode-vi C-k select-pane -U
      bind-key -T copy-mode-vi C-l select-pane -R
      bind-key -T copy-mode-vi C-\ select-pane -l

      # Easier splitting
      bind | split-window -h
      bind - split-window -v

      # No status bar
      set -g status off

      # st fix
      set -as terminal-overrides ',st*:Ss@'
    '';
  };

  programs.neovim = {
    enable = true;
    configure = {
      customRC = builtins.readFile "${dotdir}/vim/init.vim";
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
          auto-pairs
          base16-vim
          ctrlp-vim
          emmet-vim
          lightline-vim
          nerdtree
          supertab
          tabular
          vim-tmux-navigator
          zoomwintab-vim
        ];
      };
    };
    vimAlias = true;
  };
}
