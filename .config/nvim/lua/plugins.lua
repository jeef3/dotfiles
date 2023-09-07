local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data")
    .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require("packer").startup({
  function(use)
    use("wbthomason/packer.nvim")

    use("tpope/vim-eunuch") -- Better shell cmds, like :Rename

    use("tpope/vim-vinegar") -- Netrw enhancements
    use("tpope/vim-repeat") -- Get more use out of "."
    use("tpope/vim-sleuth") -- Set shiftwidth and expandtab based on current file
    use("tpope/vim-commentary") -- gcc to comment line/paragraph
    use("tpope/vim-surround") -- Change surrounds, quotes etc
    -- use("tpope/vim-obsession") -- Keep my session
    use("tpope/vim-fugitive") -- Git wrapper, :Gstatus etc

    use("Xvezda/vim-readonly") -- Lock a bunch of files like node_modules
    use("fladson/vim-kitty") -- Kitty config syntax
    use("machakann/vim-highlightedyank") -- Highlight yanked

    use("justinmk/vim-sneak") -- Minimal EasyMotion s

    use("jeef3/splitsizer.vim") -- Split resizing <c-a>, <c-s>
    use("voldikss/vim-floaterm")

    use({
      "folke/neodev.nvim",
      config = function()
        require("neodev").setup({
          library = { plugins = { "neotest" }, types = true },
        })
      end,
    })

    -- Restore cursor position
    use({
      "ethanholz/nvim-lastplace",
      config = function()
        require("nvim-lastplace").setup()
      end,
    })

    -- Newer auto-pairs
    use({
      "windwp/nvim-autopairs",
      config = function()
        require("nvim-autopairs").setup()
      end,
    })

    -- Auto-close HTML tags
    use({
      "windwp/nvim-ts-autotag",
      config = function()
        require("nvim-ts-autotag").setup()
      end,
    })

    -- Colored colors
    use({
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup()
      end,
    })

    -- Highlighting
    use({
      "nvim-treesitter/nvim-treesitter",
      config = [[require("config.treesitter")]],
      run = ":TSUpdate",
    })
    use("nvim-treesitter/playground")
    use({
      "RRethy/vim-illuminate",
      config = function()
        require("illuminate").configure({
          providers = { "lsp" },
          under_cursor = false,
        })
      end,
    })

    -- Fancy notifications
    use({
      "rcarriga/nvim-notify",
      config = function()
        vim.notify = require("notify")
      end,
    })

    -- Searching
    use({
      {
        "nvim-telescope/telescope.nvim",
        requires = {
          "nvim-lua/plenary.nvim",
          "nvim-telescope/telescope-fzf-native.nvim",
          "rcarriga/nvim-notify",
        },
        config = [[require("config.telescope")]],
      },
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
    })

    -- LSP
    use({
      {
        "neovim/nvim-lspconfig",
        requires = {
          "nvim-lua/plenary.nvim",
          "glepnir/lspsaga.nvim",
          "jose-elias-alvarez/null-ls.nvim",
        },
        config = [[require("config.lspconfig")]],
      },
      {
        -- Useful quick fix list
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
          require("trouble").setup()
        end,
      },
      {
        -- LSP and external tooling installer
        "williamboman/mason.nvim",
        requires = { "williamboman/mason-lspconfig.nvim" },
        config = function()
          require("mason").setup()
          require("mason-lspconfig").setup({ automatic_installation = true })
        end,
      },
    })

    -- Code Completion
    use({
      "hrsh7th/nvim-cmp",
      requires = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "onsails/lspkind.nvim" },
        { "ray-x/lsp_signature.nvim" },
        -- { "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" },
        { "hrsh7th/cmp-vsnip", after = "nvim-cmp" },
        -- { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
        -- { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
        -- { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
        -- { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
      },
      config = [[require("config.cmp")]],
    })

    -- Debugging
    use({
      "mfussenegger/nvim-dap",
      requires = {
        { "rcarriga/nvim-dap-ui" },
        { "theHamsta/nvim-dap-virtual-text" },
      },
      config = [[require("config.dap")]],
    })

    -- use({
    --   "mxsdev/nvim-dap-vscode-js",
    --   requires = { "mfussenegger/nvim-dap" },
    --   config = function()
    --     require("dap-vscode-js").setup({
    --       adapters = {
    --         "pwa-node",
    --         "pwa-chrome",
    --       },
    --     })
    --   end,
    -- })

    -- Testing
    use({
      "nvim-neotest/neotest",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "antoinemadec/FixCursorHold.nvim",
        "marilari88/neotest-vitest",
        "thenbe/neotest-playwright",
      },
      config = [[require("config.neotest")]],
    })

    -- Code Coverage
    use({
      "andythigpen/nvim-coverage",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("coverage").setup()
      end,
    })

    -- Theme
    use({
      "~/projects/princess.nvim",
      -- 'git@github.com:jeef3/princess.nvim.git',
      requires = { "rktjmp/lush.nvim" },
    })

    -- Tab bar
    use({
      "seblj/nvim-tabline",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("tabline").setup({
          padding = 1,
          always_show_tabs = true,
          close_icon = "×",
          separator = "▎",
        })
      end,
    })
    -- use({
    --   "romgrk/barbar.nvim",
    --   requires = {
    --     "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
    --     "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    --   },
    --   config = function()
    --     require("barbar").setup({

    --     })
    --   end,
    -- })

    -- Status line
    use({ "nvim-lualine/lualine.nvim", config = [[require("config.lualine")]] })

    -- Git and diff
    use({ "lewis6991/gitsigns.nvim", config = [[require("config.gitsigns")]] })
    use({ "sindrets/diffview.nvim", config = [[require("config.diffview")]] })

    -- Zen editing mode
    use({
      "folke/zen-mode.nvim",
      config = function()
        require("zen-mode").setup({
          window = { width = 90 },
          plugins = {
            tmux = { enabled = true },
            kitty = { enabled = true, font = "+4" },
          },
        })
      end,
    })

    -- Smooth scrolling
    use({
      "declancm/cinnamon.nvim",
      config = function()
        require("cinnamon").setup({ default_delay = 4 })
      end,
    })

    -- Strip whitespace
    use({
      "lewis6991/spaceless.nvim",
      config = function()
        require("spaceless").setup()
      end,
    })

    -- Markdown preview
    use({
      "toppair/peek.nvim",
      run = "deno task --quiet build:fast",
      config = function()
        require("peek").setup()

        vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
        vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
      end,
    })

    -- Task runner
    use({
      "stevearc/overseer.nvim",
      requires = {
        "rcarriga/nvim-notify",
        "stevearc/dressing.nvim",
      },
      config = [[require("config.overseer")]],
    })

    use({
      "gelguy/wilder.nvim",
      config = function()
        local wilder = require("wilder")
        wilder.setup({
          modes = { ":" },
          next_key = "<C-k>",
          previous_key = "<C-j>",
          accept_key = "<Tab>",
          -- enable_cmdline_enter = 0,
        })

        wilder.set_option(
          "pipeline",
          wilder.branch(wilder.cmdline_pipeline({
            fuzzy = 1,
          }))
        )

        wilder.set_option(
          "renderer",
          wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
            highlights = {
              border = "Normal",
            },
            border = "rounded",
            pumblend = 20,
            -- highlighter applies highlighting to the candidates
            highlighter = wilder.basic_highlighter(),
            reverse = 1,
            left = { " ", wilder.popupmenu_devicons() },
            right = { " ", wilder.popupmenu_scrollbar() },
          }))
        )
      end,
    })

    -- Session management
    -- use({
    --   "rmagatti/auto-session",
    --   requires = { "rmagatti/session-lens", "nvim-telescope/telescope.nvim" },
    --   config = function()
    --     require("session-lens").setup()
    --     vim.g.auto_sesion_use_git_branch = true
    --     require("auto-session").setup({})
    --   end,
    -- })
    use({
      "olimorris/persisted.nvim",
      config = function()
        require("persisted").setup({
          autoload = true,
          use_git_branch = true,
        })
      end,
    })
    -- use({
    --   "stevearc/resession.nvim",
    --   config = function()
    --     require("resession").setup({
    --       autosave = {
    --         enabled = true,
    --         interval = 60,
    --         notify = false,
    --       },
    --     })
    --   end,
    -- })
    --
    use({
      "folke/which-key.nvim",
      config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        require("which-key").setup({
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        })
      end,
    })

    if packer_bootstrap then
      require("packer").sync()
    end
  end,
  config = {
    display = {
      open_fn = require("packer.util").float,
    },
  },
})
