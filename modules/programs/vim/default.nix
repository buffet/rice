{ config, lib, pkgs, ... }:
let
  cfg = config.buffet.programs.vim;
  sessionType = config.buffet.desktop.sessionType;
in
  with lib; {
    options = {
      buffet.programs.vim = {
        enable = mkEnableOption "vim";
      };
    };

    config = {
      buffet.home = {
        home = {
          sessionVariables = { EDITOR = "nvim"; };
          packages = with pkgs; [ fzf nodejs ]; # TODO: make pretty
        };

        programs.neovim = {
          enable = true;
          vimAlias = true;

          # TODO: take a look at puremourning/vimspector

          # iamcco/markdown-preview.nvim

          # honza/vim-snippets ultisnips?

          # lsp:
          # https://github.com/liuchengxu/vista.vim
          # https://github.com/antoinemadec/coc-fzf
          plugins = with pkgs.vimPlugins; [
            any-jump
            auto-pairs
            detectindent
            fzf-vim
            lightline-vim
            nerdcommenter
            quick-scope
            rainbow_parentheses
            tabular
            targets-vim
            vim-colors-solarized
            vim-exchange
            vim-fugitive
            vim-smoothie
            vim-yoink
            vim-indent-guides
            vim-repeat
            vim-signify
            vim-sneak
            vim-surround
            vim-visual-multi
            vim-which-key # TODO: make pretty

            # CoC
            coc-fzf
            coc-nvim
            coc-rust-analyzer

            # Languages
            vim-nix
          ];

          extraConfig = builtins.readFile ./init.vim;
        };
      };
    };
  }
