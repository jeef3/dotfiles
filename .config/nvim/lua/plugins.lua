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

  "ethanholz/nvim-lastplace", -- Restore cursor position

  { "windwp/nvim-ts-autotag", config = true }, -- Auto-close HTML tags

  -- Colored colors
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
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
  -- {
  --   "mfussenegger/nvim-dap",
  --   dependencies = {
  --     { "rcarriga/nvim-dap-ui" },
  --     { "theHamsta/nvim-dap-virtual-text" },
  --   },
  --   config = [[require("config.dap")]],
  -- },

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

  -- {
  --   "gelguy/wilder.nvim",
  --   config = function()
  --     local wilder = require("wilder")
  --     wilder.setup({
  --       modes = { ":", "/" },
  --       next_key = "<C-k>",
  --       previous_key = "<C-j>",
  --       accept_key = "<Tab>",
  --     })

  --     wilder.set_option(
  --       "pipeline",
  --       wilder.branch(wilder.cmdline_pipeline({
  --         fuzzy = 1,
  --       }))
  --     )

  --     wilder.set_option(
  --       "renderer",
  --       wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
  --         highlights = {
  --           border = "Normal",
  --         },
  --         border = "rounded",
  --         pumblend = 20,
  --         -- highlighter applies highlighting to the candidates
  --         highlighter = wilder.basic_highlighter(),
  --         reverse = 1,
  --         left = { " ", wilder.popupmenu_devicons() },
  --         right = { " ", wilder.popupmenu_scrollbar() },
  --       }))
  --     )
  --   end,
  -- },

  ------------------
  -- Persisted
  --
  -- 💾 Simple session management for Neovim with git branching, autoloading and
  -- Telescope support
  --
  -- https://github.com/olimorris/persisted.nvim
  ------------------
  {
    "olimorris/persisted.nvim",
    opts = {
      autoload = true,
      use_git_branch = true,
    },
    config = true,
  },
}
