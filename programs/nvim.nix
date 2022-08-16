{
  lib,
  pkgs,
  ...
} @ inputs: {
  home-manager.users.buffet = {
    home.sessionVariables = {
      EDITOR = "nvim";
    };

    # TODO: keybinds
    # TODO: looks
    # TODO: options
    programs.neovim = {
      enable = true;
      plugins = let
        buildPlugin = name:
          pkgs.vimUtils.buildNeovimPluginFrom2Nix {
            inherit name;
            src = inputs."${name}";
          };
        buildPlugins = names: lib.attrsets.genAttrs names buildPlugin;
        plugins = buildPlugins ["lsp-trouble"];
      in
        with pkgs.vimPlugins;
        with plugins; [
          {plugin = editorconfig-nvim;}
          {plugin = fugitive;}
          {plugin = lsp-trouble;}
          {plugin = nvim-autopairs;}
          {plugin = rust-vim;}
          {plugin = tabular;}
          {plugin = vim-nix;}
          {plugin = vim-repeat;}

          {
            plugin = gitsigns-nvim;
            config = "lua require 'gitsigns'.setup()";
          }

          # TODO: replace with own bar
          {
            plugin = lightline-vim;
            config = "let g:lightline = { 'colorscheme': 'solarized' }";
          }

          {
            plugin = lspsaga-nvim;
            config = "lua require 'lspsaga'.init_lsp_saga()";
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
            config = let
              configure = srv: "lua require 'lspconfig'.${srv}.setup {}";
              servers = [
                "clangd"
                "rust_analyzer"
              ];
            in
              lib.strings.concatStringsSep "\n" (builtins.map configure servers);
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
            config = builtins.replaceStrings ["\n"] [""] ''
              lua require 'nvim-treesitter.configs'.setup {
              highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
                },
              }
            '';
          }

          {
            plugin = vimwiki;
            # TODO: vimwiki config
          }
        ];
    };
  };
}
