vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'wincent/terminus'        -- Better terminal integration, cursor shapes
  use 'tpope/vim-eunuch'        -- Better shell cmds, like :Rename

  use 'fladson/vim-kitty' -- Kitty config syntax

  -- Newer auto-pairs
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end
  }

  -- Auto-close HTML tags 
  use {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end
  }  
  
  -- Colored colors
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  }

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
      -- Useful quick fix list
      'folke/trouble.nvim',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function()
        require('trouble').setup()
      end
    },
    {
      -- LSP and external tooling installer
      'williamboman/mason.nvim',
      config = function()
        require('mason').setup()
      end
    },
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

  -- Debugging
  use {
    'mfussenegger/nvim-dap',
    requires = {
      'rcarriga/nvim-dap-ui'
    },
    config = [[require('config.dap')]]
  }

  -- Theme
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

  -- Git and diff
  use {
    'lewis6991/gitsigns.nvim',
    config = [[require('config.gitsigns')]]
  }

  use {
    'sindrets/diffview.nvim',
    config = [[require('config.diffview')]]
  }

  -- Zen editing mode
  use {
    'folke/zen-mode.nvim',
    config = function()
      require('zen-mode').setup({
        window = {
          width = 90
        },
        plugins = {
          tmux = { enabled = true },
          kitty = {
            enabled = true,
            font = "+4",
          },
        }
      })
    end
  }

  -- Smooth scrolling
  use {
    'declancm/cinnamon.nvim' ,
    config = function()
      require('cinnamon').setup({
        default_delay = 4,
      })
    end
  }
end)
