return {
  "tpope/vim-eunuch", -- Better shell cmds, like :Rename

  "tpope/vim-vinegar", -- Netrw enhancements
  "tpope/vim-repeat", -- Get more use out of "."
  "tpope/vim-sleuth", -- Set shiftwidth and expandtab based on current file
  "tpope/vim-commentary", -- gcc to comment line/paragraph
  "tpope/vim-surround", -- Change surrounds, quotes etc
  "tpope/vim-fugitive", -- Git wrapper, :Gstatus etc

  "Xvezda/vim-readonly", -- Lock a bunch of files like node_modules
  "fladson/vim-kitty", -- Kitty config syntax
  "machakann/vim-highlightedyank", -- Highlight yanked

  "justinmk/vim-sneak", -- Minimal EasyMotion s
  "jeef3/splitsizer.vim", -- Split resizing <c-a>, <c-s>

  -- {
  --   "folke/neodev.nvim",
  --   config = function()
  --     require("neodev").setup({
  --       library = { plugins = { "neotest" }, types = true },
  --     })
  --   end,
  -- },

  -- Restore cursor position
  {
    "ethanholz/nvim-lastplace",
    config = function()
      require("nvim-lastplace").setup()
    end,
  },

  -- Newer auto-pairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- Auto-close HTML tags
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- Colored colors
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },

  -- Highlight other uses of a word
  {
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure({
        providers = { "lsp" },
        under_cursor = false,
      })
    end,
  },

  -- Fancy notifications
  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end,
  },

  -- Useful quick fix list
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup()
    end,
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "rcarriga/nvim-dap-ui" },
      { "theHamsta/nvim-dap-virtual-text" },
    },
    config = [[require("config.dap")]],
  },

  -- Testing
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "marilari88/neotest-vitest",
      "thenbe/neotest-playwright",
    },
    config = [[require("config.neotest")]],
  },

  -- Code Coverage
  {
    "andythigpen/nvim-coverage",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("coverage").setup()
    end,
  },

  -- Theme
  {
    -- "~/projects/princess.nvim",
    "git@github.com:jeef3/princess.nvim.git",
    dependencies = { "rktjmp/lush.nvim" },
    config = function()
      vim.cmd.colorscheme("princess_theme")
    end,
  },

  -- Git and diff
  { "lewis6991/gitsigns.nvim", config = [[require("config.gitsigns")]] },
  { "sindrets/diffview.nvim", config = [[require("config.diffview")]] },

  -- Zen editing mode
  {
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
  },

  -- Smooth scrolling
  {
    "declancm/cinnamon.nvim",
    opts = {
      default_delay = 4,
    },
  },

  -- Strip whitespace
  {
    "lewis6991/spaceless.nvim",
    config = function()
      require("spaceless").setup()
    end,
  },

  -- Markdown preview
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup()

      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },

  -- Task runner
  {
    "stevearc/overseer.nvim",
    dependencies = {
      "rcarriga/nvim-notify",
      "stevearc/dressing.nvim",
    },
    config = [[require("config.overseer")]],
  },

  {
    "gelguy/wilder.nvim",
    config = function()
      local wilder = require("wilder")
      wilder.setup({
        modes = { ":", "/" },
        next_key = "<C-k>",
        previous_key = "<C-j>",
        accept_key = "<Tab>",
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
  },

  {
    "olimorris/persisted.nvim",
    config = function()
      require("persisted").setup({
        autoload = true,
        use_git_branch = true,
      })
    end,
  },
}
