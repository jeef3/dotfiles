vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'wincent/terminus'  -- Better terminal integration, cursor shapes
  use 'tpope/vim-eunuch'  -- Better shell cmds, like :Rename

  use 'lewis6991/gitsigns.nvim'

  -- Highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    config = [[require('config.treesitter')]],
    run = ':TSUpdate'
  }
  use 'nvim-treesitter/playground'

  -- Searching
  use {
    {
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'telescope-fzf-native.nvim',
      },
      config = [[require('config.telescope')]],
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
  }

  -- LSP
  use {
    'neovim/nvim-lspconfig',
    'glepnir/lspsaga.nvim',
     'jose-elias-alvarez/null-ls.nvim',
    'folke/trouble.nvim',
    config = [[require('config.lsp')]]
  }

  use {
     '~/projects/princess.nvim',
     -- 'git@github.com:jeef3/princess.nvim.git',
  }
end)
