{
  lib,
  pkgs,
  ...
} @ inputs: {
  home-manager.users.buffet = {
    home.sessionVariables = {
      EDITOR = "nvim";
    };

    home.packages = with pkgs; [
      libclang
      nil
      rust-analyzer
    ];

    programs.neovim = let
      leader = ",";
    in {
      enable = true;
      plugins = let
        buildPlugin = pname:
          pkgs.vimUtils.buildVimPluginFrom2Nix {
            inherit pname;
            version = "unknown";
            src = inputs."${pname}";
          };
        buildPlugins = names: lib.attrsets.genAttrs names buildPlugin;
        plugins = buildPlugins [
          "cmp-conventionalcommits"
          "cmp-git"
          "gh-nvim"
          "nvim-cmp-vlime"
          "rust-tools-nvim"
          "vlime"
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
          {plugin = lualine-lsp-progress;}
          {plugin = nvim-cmp-vlime;}
          {plugin = playground;}
          {plugin = rust-vim;}
          {plugin = tabular;}
          {plugin = vim-nix;}
          {plugin = vim-parinfer;}
          {plugin = vim-repeat;}
          {plugin = vlime;}

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
            plugin = gh-nvim;
            config = ''
              lua <<EOF
                require 'litee.lib'.setup {}
                require 'litee.gh'.setup {}
              EOF

              nnoremap <silent> ${leader}qcc :GHCloseCommit<cr>
              nnoremap <silent> ${leader}qce :GHExpandCommit<cr>
              nnoremap <silent> ${leader}qct :GHOpenToCommit<cr>
              nnoremap <silent> ${leader}qcp :GHPopOutCommit<cr>
              nnoremap <silent> ${leader}qcz :GHCollapseCommit<cr>

              nnoremap <silent> ${leader}qip :GHPreviewIssue<cr>

              nnoremap <silent> ${leader}qrb :GHStartReview<cr>
              nnoremap <silent> ${leader}qrc :GHCloseReview<cr>
              nnoremap <silent> ${leader}qrd :GHDeleteReview<cr>
              nnoremap <silent> ${leader}qre :GHExpandReview<cr>
              nnoremap <silent> ${leader}qrs :GHSubmitReview<cr>
              nnoremap <silent> ${leader}qrz :GHCollapseReview<cr>

              nnoremap <silent> ${leader}qpc :GHClosePR<cr>
              nnoremap <silent> ${leader}qpd :GHPRDetails<cr>
              nnoremap <silent> ${leader}qpe :GHExpandPR<cr>
              nnoremap <silent> ${leader}qpo :GHOpenPR<cr>
              nnoremap <silent> ${leader}qpp :GHPopOutPR<cr>
              nnoremap <silent> ${leader}qpr :GHRefreshPR<cr>
              nnoremap <silent> ${leader}qpt :GHOpenToPR<cr>
              nnoremap <silent> ${leader}qpz :GHCollapsePR<cr>

              nnoremap <silent> ${leader}qtc :GHCreateThread<cr>
              nnoremap <silent> ${leader}qtn :GHNextThread<cr>
              nnoremap <silent> ${leader}qt :GHToggleThread<cr>
            '';
          }

          {
            plugin = gitsigns-nvim;
            config = ''
              lua <<EOF
                require 'gitsigns'.setup {
                  signs = {
                    add    = { text = '┆' },
                    change = { text = '┆' },
                  },
                }
              EOF
            '';
          }

          {
            plugin = litee-nvim;
            config = ''
              lua require 'litee.lib'.setup {}

              nnoremap <silent> ${leader}lt :LTPanel<cr>
            '';
          }

          {
            plugin = litee-calltree-nvim;
            config = ''
              lua require 'litee.calltree'.setup {}

              nnoremap <silent> ${leader}lci :lua vim.lsp.buf.incoming_calls()<cr>
              nnoremap <silent> ${leader}lco :lua vim.lsp.buf.outgoing_calls()<cr>
            '';
          }

          {
            plugin = litee-symboltree-nvim;
            config = ''
              lua require 'litee.symboltree'.setup {}

              nnoremap <silent> ${leader}ls :lua vim.lsp.buf.document_symbol()<cr>
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
            plugin = kanagawa-nvim;
            config = ''
              lua <<EOF
                local colors = require 'kanagawa.colors'.setup();

                require 'kanagawa'.setup {
                  overrides = {
                    EndOfBuffer = { fg = colors.waveBlue2 },
                  },
                }
              EOF
              colorscheme kanagawa
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
                    { name = 'vlime' },
                    { name = 'vsnip' },
                  },
                }
              EOF
            '';
          }

          {
            plugin = nvim-dap;
            config = ''
              nnoremap <silent> <f5> <cmd>lua require 'dap'.continue()<cr>
              nnoremap <silent> <f10> <cmd>lua require 'dap'.step_over()<cr>
              nnoremap <silent> <f11> <cmd>lua require 'dap'.step_into()<cr>
              nnoremap <silent> <f12> <cmd>lua require 'dap'.step_out()<cr>
              nnoremap <silent> ${leader}db <cmd>lua require'dap'.toggle_breakpoint()<cr>
              nnoremap <silent> ${leader}dB <cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>
              nnoremap <silent> ${leader}dr <cmd>lua require'dap'.repl.open()<cr>
              nnoremap <silent> ${leader}dl <cmd>lua require'dap'.run_last()<cr>

              lua <<EOF
                local dap = require 'dap'

                dap.adapters.lldb = {
                  type = 'executable',
                  command = '${pkgs.lldb}/bin/lldb-vscode',
                  name = 'lldb',
                }

                local lldb = {
                  name = 'Launch lldb',
                  type = 'lldb',
                  request = 'launch',
                  program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                  end,
                  cwd = "''${workspaceFolder}",
                  stopOnEntry = false,
                  runInTerminal = true,
                  args = {},
                }

                dap.configurations.rust = { lldb }
              EOF
            '';
          }

          {
            plugin = nvim-dap-ui;
            config = ''
              lua require 'dapui'.setup()
            '';
          }

          {
            plugin = nvim-dap-virtual-text;
            config = ''
              lua <<EOF
                require 'nvim-dap-virtual-text'.setup {
                  commented = true,
                }
              EOF
            '';
          }

          {
            plugin = nvim-hlslens;
            config = ''
              lua require 'hlslens'.setup {}
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
                "nil_ls"
                "rust_analyzer"
              ];
              serverConfigs = lib.strings.concatStringsSep "\n" (builtins.map configure servers);
            in ''
              lua <<EOF
                local lspconfig = require 'lspconfig'
                local caps = require 'cmp_nvim_lsp'.default_capabilities(
                  vim.lsp.protocol.make_client_capabilities()
                )
                ${serverConfigs}
              EOF
            '';
          }

          {
            plugin = nvim-scrollbar;
            config = ''
              lua <<EOF
                require 'scrollbar'.setup {
                  show_in_active_only = true,
                  handlers = {
                    search = true,
                  },
                }
              EOF
            '';
          }

          {
            plugin = nvim-treesitter.withPlugins (plugins:
              with plugins; [
                tree-sitter-bash
                tree-sitter-bibtex
                tree-sitter-c
                tree-sitter-c-sharp
                tree-sitter-clojure
                tree-sitter-cmake
                tree-sitter-comment
                tree-sitter-commonlisp
                tree-sitter-cpp
                tree-sitter-css
                tree-sitter-devicetree
                tree-sitter-dockerfile
                tree-sitter-dot
                tree-sitter-fennel
                tree-sitter-glsl
                tree-sitter-go
                tree-sitter-java
                tree-sitter-javascript
                tree-sitter-json
                tree-sitter-latex
                tree-sitter-llvm
                tree-sitter-lua
                tree-sitter-make
                tree-sitter-markdown
                tree-sitter-markdown-inline
                tree-sitter-nix
                tree-sitter-perl
                tree-sitter-python
                tree-sitter-regex
                tree-sitter-rst
                tree-sitter-rust
                tree-sitter-sql
                tree-sitter-scheme
                tree-sitter-svelte
                tree-sitter-toml
                tree-sitter-typescript
                tree-sitter-vim
                tree-sitter-yaml
                tree-sitter-zig
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
            plugin = rust-tools-nvim;
            config = ''
              lua require 'rust-tools'.setup {}
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
            plugin = trouble-nvim;
            config = ''
              nnoremap <silent> ${leader}t :TroubleToggle<cr>
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
        set signcolumn=yes

        set shiftwidth=4
        set tabstop=4
        set expandtab

        set shiftround
        set autoindent
        set smartindent

        highlight! ExtraWhitespace guibg=${theme.normal.red}
        match ExtraWhitespace /\s\+$/

        autocmd FileType lisp setlocal shiftwidth=2 tabstop=2

        lua <<EOF
          vim.diagnostic.config {
            severity_sort = true,
          }
        EOF
      '';
    };
  };
}
