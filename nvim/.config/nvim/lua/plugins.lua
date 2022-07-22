local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'neovim/nvim-lspconfig' -- TODO: config?

  use { -- TODO: config
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
    },
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    requires = {
      -- TODO :ts text-objects?
    },
    config = function()
      -- TODO: config
    end,
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-lua/popup.nvim',
    },
  }

  use {
    'overcache/NeoSolarized',
    config = function()

    end,
  }

  -- TODO: latex?

  -- TODO: vim-slash replacement
  use 'editorconfig/editorconfig-vim'
  --use 'folke/lsp-trouble.nvim'
  use 'itchyny/lightline.vim' -- TODO: look into alternatives
  --use 'roryokane/detectindent'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-repeat'
  -- vim surround?
  -- gitsigns?
  -- telescope

  if packer_bootstrap then
    require('packer').sync()
  end
end)
