{pkgs, ...}: {
  home-manager.users.buffet = {
    home.sessionVariables = {
      EDITOR = "nvim";
    };

    # TODO: keybinds
    # TODO: looks
    # TODO: options
    programs.neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        # TODO: vimplugin lsp-trouble
        # TODO: vimplugin nvim-lspconfig
        {plugin = editorconfig-nvim;}
        {plugin = fugitive;}
        {plugin = nvim-autopairs;}
        {plugin = rust-vim;}
        {plugin = tabular;}
        {plugin = vim-nix;}
        {plugin = vim-repeat;}
        {plugin = vimwiki;}

        {
          plugin = gitsigns-nvim;
          config = "lua gitsigns.setup()";
        }

        {
          plugin = lightline-vim;
          config = "let g:lightline = { 'colorscheme': 'solarized' }";
        }

        {
          plugin = lspsaga-nvim;
          # TODO: lspsaga config
        }

        {
          plugin = NeoSolarized;
          config = ''
            set background=light
            colorscheme NeoSolarized
          '';
        }

        {
          plugin = nvim-lspconfig;
          # TODO: lspconfig config
        }

        {
          plugin = telescope-nvim;
          # TODO: telescope-nvim config
        }

        {
          plugin = nvim-treesitter.withPlugins (plugins:
            with plugins; [
              tree-sitter-bash
              tree-sitter-bibtex
              tree-sitter-c
              tree-sitter-cmake
              tree-sitter-comment
              tree-sitter-cpp
              tree-sitter-css
              tree-sitter-devicetree
              tree-sitter-dockerfile
              tree-sitter-fennel
              tree-sitter-go
              tree-sitter-javascript
              tree-sitter-json
              tree-sitter-latex
              tree-sitter-lua
              tree-sitter-make
              tree-sitter-markdown
              tree-sitter-nix
              tree-sitter-perl
              tree-sitter-python
              tree-sitter-regex
              tree-sitter-rust
              tree-sitter-toml
            ]);
        }
        # TODO: tree-sitter config
      ];
    };
  };
}
