local exec = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
end

exec 'packadd packer.nvim'

require('packer').startup(function ()
    use 'wbthomason/packer.nvim'

    use 'Olical/aniseed'
    use 'norcalli/nvim.lua'

    -- TODO: look into galaxyline
    -- TODO: setup treesitter
    -- TODO: look into diffview
    -- TODO: look into iamcco/markdown-preview.nvim
    -- TODO: look into vsnip (enable for compe)
    use 'ap/vim-css-color'
    use 'folke/lsp-trouble.nvim'
    use 'folke/which-key.nvim'
    use 'glepnir/lspsaga.nvim'
    use 'godlygeek/tabular'
    use 'hrsh7th/nvim-compe'
    use 'itchyny/lightline.vim'
    use 'jiangmiao/auto-pairs'
    use 'junegunn/goyo.vim'
    use 'junegunn/limelight.vim'
    use 'junegunn/rainbow_parentheses.vim'
    use 'junegunn/vim-slash'
    use 'justinmk/vim-sneak'
    use 'nathanaelkane/vim-indent-guides'
    use 'neovim/nvim-lspconfig'
    use 'overcache/NeoSolarized'
    use 'psliwka/vim-smoothie'
    use 'ray-x/lsp_signature.nvim'
    use 'roryokane/detectindent'
    use 'rust-lang/rust.vim'
    use 'sheerun/vim-polyglot'
    use 'simrat39/rust-tools.nvim'
    use 'tommcdo/vim-exchange'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-repeat'
    use 'tpope/vim-surround'
    use 'vmchale/ats-vim'
    use 'wellle/targets.vim'

    use {
        'Olical/conjure',
        requires = {
            'tami5/compe-conjure'
        },

        config = "vim.g['conjure#client#fennel#aniseed#aniseed_module_prefix'] = 'aniseed.'",
    }

    use {
        'eraserhd/parinfer-rust',
        run = 'cargo build --release'
    }

    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
        },
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-lua/popup.nvim',
        },
    }
end)

vim.g['aniseed#env'] = true
