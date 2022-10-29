{
  lib,
  pkgs,
  ...
} @ inputs: {
  home-manager.users.buffet = {
    home.sessionVariables = {
      EDITOR = "nvim";
    };

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
        plugins = buildPlugins [
          "cmp-conventionalcommits"
          "cmp-git"
          "lsp-trouble"
        ];
      in
        with pkgs.vimPlugins;
        with plugins; [
          {plugin = cmp-buffer;}
          {plugin = cmp-calc;}
          {plugin = cmp-conventionalcommits;}
          {plugin = cmp-latex-symbols;}
          {plugin = cmp-nvim-lsp;}
          {plugin = cmp-path;}
          {plugin = cmp-treesitter;}
          {plugin = cmp-vsnip;}
          {plugin = editorconfig-nvim;}
          {plugin = friendly-snippets;}
          {plugin = fugitive;}
          {plugin = lsp-trouble;}
          {plugin = lualine-lsp-progress;}
          {plugin = playground;}
          {plugin = rust-vim;}
          {plugin = tabular;}
          {plugin = vim-nix;}
          {plugin = vim-repeat;}

          {
            plugin = cmp-git;
            config = "lua require 'cmp_git'.setup()";
          }

          {
            plugin = crates-nvim;
            config = ''
              lua require 'crates'.setup()

              nnoremap <silent> ${leader}ct :lua require('crates').toggle()<cr>
              nnoremap <silent> ${leader}cr :lua require('crates').reload()<cr>

              nnoremap <silent> ${leader}cv :lua require('crates').show_versions_popup()<cr>
              nnoremap <silent> ${leader}cf :lua require('crates').show_features_popup()<cr>
              nnoremap <silent> ${leader}cd :lua require('crates').show_dependencies_popup()<cr>

              nnoremap <silent> ${leader}cu :lua require('crates').update_crate()<cr>
              vnoremap <silent> ${leader}cu :lua require('crates').update_crates()<cr>
              nnoremap <silent> ${leader}ca :lua require('crates').update_all_crates()<cr>
              nnoremap <silent> ${leader}cU :lua require('crates').upgrade_crate()<cr>
              vnoremap <silent> ${leader}cU :lua require('crates').upgrade_crates()<cr>
              nnoremap <silent> ${leader}cA :lua require('crates').upgrade_all_crates()<cr>

              nnoremap <silent> ${leader}cH :lua require('crates').open_homepage()<cr>
              nnoremap <silent> ${leader}cR :lua require('crates').open_repository()<cr>
              nnoremap <silent> ${leader}cD :lua require('crates').open_documentation()<cr>
              nnoremap <silent> ${leader}cC :lua require('crates').open_crates_io()<cr>
            '';
          }

          {
            plugin = gitsigns-nvim;
            config = ''
              lua require 'gitsigns'.setup()
              set signcolumn=yes
            '';
          }

          {
            plugin = lualine-nvim;
            config = ''
              lua <<EOF
                require 'lualine'.setup {
                    options = {
                      icons_enabled = true,
                      theme = 'auto',
                      component_separators = {left = ''', right = '''},
                      section_separators = {left = ''', right = '''},
                      disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                      },
                      ignore_focus = {},
                      always_divide_middle = true,
                      globalstatus = false,
                      refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                      }
                    },
                    sections = {
                      lualine_a = {'mode'},
                      lualine_b = {'diff', 'diagnostics'},
                      lualine_c = {
                        'filename',
                        {
                          'lsp_progress',
                          display_components = {'lsp_client_name', 'spinner'},
                          spinner_symbols = {'⠋', '⠙', '⠸', '⠴', '⠦', '⠇'},
                          timer = {spinner = '75'}
                        }
                      },
                      lualine_x = {'encoding', 'fileformat', 'filetype'},
                      lualine_y = {'progress'},
                      lualine_z = {'location'}
                    },
                    inactive_sections = {
                      lualine_a = {},
                      lualine_b = {},
                      lualine_c = {'filename'},
                      lualine_x = {'location'},
                      lualine_y = {},
                      lualine_z = {}
                    },
                    tabline = {},
                    winbar = {},
                    inactive_winbar = {},
                    extensions = {}
                }
              EOF
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
            plugin = kanagawa-nvim;
            config = ''
              colorscheme kanagawa
            '';
          }

          {
            plugin = nvim-autopairs;
            config = "lua require 'nvim-autopairs'.setup {}";
          }

          {
            plugin = nvim-cmp;
            config = ''
              set completeopt=menu,menuone,noselect

              lua <<EOF
                local cmp = require 'cmp'

                cmp.setup {
                  snippet = {
                    expand = function(args)
                      vim.fn["vsnip#anonymous"](args.body)
                    end,
                  },
                  window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                  },
                  mapping = {
                    ['<c-space>'] = cmp.mapping.confirm({ select = true }),
                    ['<c-p>']     = cmp.mapping.select_prev_item(select_opts),
                    ['<c-n>']     = cmp.mapping.select_next_item(select_opts),
                    ['<c-d>']     = cmp.mapping.scroll_docs(4),
                    ['<c-u>']     = cmp.mapping.scroll_docs(-4),
                    ['<c-e>']     = cmp.mapping.abort(),
                  },
                  sources = cmp.config.sources {
                    { name = 'buffer' },
                    { name = 'calc' },
                    { name = 'conventionalcommits' },
                    { name = 'crates' },
                    { name = 'git' },
                    { name = 'latex_symbols' },
                    { name = 'nvim_lsp' },
                    { name = 'path' },
                    { name = 'treesitter' },
                    { name = 'vsnip' },
                  },
                }
              EOF
            '';
          }

          {
            plugin = nvim-lspconfig;
            config = let
              configure = srv: ''
                lspconfig.${srv}.setup {
                  capabilities = caps,
                }
              '';
              servers = [
                "clangd"
                "gopls"
                "rust_analyzer"
              ];
              serverConfigs = lib.strings.concatStringsSep "\n" (builtins.map configure servers);
            in ''
              lua <<EOF
                local lspconfig = require 'lspconfig'
                local caps = require 'cmp_nvim_lsp'.update_capabilities(
                  vim.lsp.protocol.make_client_capabilities()
                )
                ${serverConfigs}
              EOF
            '';
          }

          {
            plugin = telescope-nvim;
            config = ''
              nnoremap <silent> ${leader}f :Telescope find_files<cr>
              nnoremap <silent> ${leader}F :Telescope find_files hidden=true no_ignore=true<cr>
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
            config = ''
              lua <<EOF
                require 'nvim-treesitter.configs'.setup {
                highlight = {
                  enable = true,
                  additional_vim_regex_highlighting = false,
                  },
                }
              EOF
            '';
          }

          {
            plugin = vim-vsnip;
            config = ''
              imap <expr> <c-k> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'
              smap <expr> <c-k> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'
              imap <expr> <c-j> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
              smap <expr> <c-j> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
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
        set wrap
        set breakindent
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
