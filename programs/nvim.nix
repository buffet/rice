{
  lib,
  pkgs,
  ...
} @ inputs: {
  home-manager.users.buffet = {
    home.sessionVariables = {
      EDITOR = "nvim";
    };

    # TODO: completion
    programs.neovim = let
      leader = ",";
    in {
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
            config = ''
              lua require 'gitsigns'.setup()
              set signcolumn=yes
            '';
          }

          # TODO: replace with own bar
          {
            plugin = lightline-vim;
            config = ''
              let g:lightline = { 'colorscheme': 'solarized' }
              set noshowmode
            '';
          }

          {
            plugin = lspsaga-nvim;
            config = ''
              lua require 'lspsaga'.init_lsp_saga()

              nnoremap <silent> ${leader}a :Lspsaga code_action<cr>
              nnoremap <silent> ${leader}r :Lspsaga rename<cr>
              nnoremap <silent> gd :lua vim.lsp.buf.definition()<cr>
              nnoremap <silent> gD :lua vim.lsp.buf.declaration()<cr>
            '';
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
            config = ''
              nnoremap <silent> ${leader}f :Telescope find_files<cr>
              nnoremap <silent> ${leader}g :Telescope live_grep<cr>
              nnoremap <silent> ${leader}b :Telescope buffers<cr>
              nnoremap <silent> ${leader}: :Telescope commands<cr>
            '';
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

      extraConfig = let
        theme = import ../theme.nix;
      in ''
        " keybinds
        let mapleader = "${leader}"
        let g:mapleader = "${leader}"

        inoremap kj <esc>

        vnoremap < <gv
        vnoremap > >gv

        nnoremap <c-h> <c-w>h
        nnoremap <c-j> <c-w>j
        nnoremap <c-k> <c-w>k
        nnoremap <c-l> <c-w>l

        nnoremap <leader>s :w<cr>

        " misc
        set termguicolors
        set mouse=a
        set undofile
        set hidden
        set encoding=utf-8
        set hlsearch
        set incsearch
        set ignorecase
        set smartcase
        set lazyredraw
        set splitbelow
        set splitright
        set matchtime=2
        set showmatch
        set nowrap
        set nowritebackup
        set updatetime=250
        set colorcolumn=+1
        set cursorline

        set shiftwidth=4
        set tabstop=4
        set expandtab

        set shiftround
        set autoindent
        set smartindent

        highlight! ExtraWhitespace guibg=${theme.normal.red}
        match ExtraWhitespace /\s\+$/
      '';
    };
  };
}
