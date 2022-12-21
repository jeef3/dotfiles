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
    config = [[require('config.lsp')]],
    {
      'folke/trouble.nvim',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function()
        require('trouble').setup()
      end
    }
  }

  -- Code Completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'onsails/lspkind.nvim' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-vsnip', after = 'nvim-cmp' },
      -- { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      -- { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      -- { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
      -- { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
    },
    config = [[require('config.cmp')]]
  }

  use {
     '~/projects/princess.nvim',
     -- 'git@github.com:jeef3/princess.nvim.git',
    requires = { 'rktjmp/lush.nvim' }
  }

  -- Tab bar
  use {
    'seblj/nvim-tabline',
    config = function()
      require('tabline').setup({
        padding = 1,
        always_show_tabs = true,
        close_icon = '×',
        separator = '▎'
      })
    end
  }

  -- Status line
  use {
    'nvim-lualine/lualine.nvim',
    config = [[require('config.lualine')]]
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = [[require('config.gitsigns')]]
  }
end)
