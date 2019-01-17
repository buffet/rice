{ config, pkgs, ... }:

let dotdir = toString ../.;
in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = {
    file.".config/sway/config".source = "${dotdir}/sway/config";

    packages = with pkgs; [
      exa
      htop
      neofetch
      ranger
      ripgrep
    ];

    sessionVariables = {
      EDITOR = "nvim";
    };
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
      customRC = builtins.readFile ../vim/init.vim;
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
          base16-vim
          ctrlp-vim
          supertab
          tabular
          vim-tmux-navigator
        ];
      };
    };
    vimAlias = true;
  };

  programs.termite = {
    enable = true;
    font = "DejaVuSansMono";
  };

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    history.path = ".config/zsh/zsh_history";
    initExtra = ''
      PROMPT="[%F{green}%n%f@%F{green}%m %B%F{blue}%1~%b%f] "
      bindkey -e
    '';
    shellAliases = {
      def-build = "nix-build -E \"with import <nixpkgs> {}; callPackage ./. {}\"";
      def-shell = "nix-shell -E \"with import <nixpkgs> {}; callPackage ./. {}\" --pure";
      e = "exa";
      eal = "exa -al";
      el = "exa -l";
      ra = "ranger";
      ta = "tmux attach-session -t";
      tkill = "tmux kill-session -t";
      tls = "tmux list-sessions";
      tnew = "tmux new -s";
      v = "nvim";
    };
  };
}
