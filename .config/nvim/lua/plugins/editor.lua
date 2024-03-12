return {
  ------------------
  -- NEO Tree
  --
  -- Neovim plugin to manage the file system and other tree like structures.
  --
  -- https://github.com/nvim-neo-tree/neo-tree.nvim
  ------------------
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",

      "nvim-tree/nvim-web-devicons",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    opts = {
      filesystem = {
        bind_to_cwd = false, -- I like to keep my cwd unchanged
        hijack_netrw_behavior = "open_current",
        filtered_items = {
          visible = true,
          hide_hidden = false,
        },
      },
      window = {
        mappings = {
          ["-"] = "navigate_up",
          ["/"] = "fuzzy_finder",
        },
        fuzzy_finder_mappings = {
          ["<down>"] = "move_cursor_down",
          ["<C-j>"] = "move_cursor_down",
          ["<up>"] = "move_cursor_up",
          ["<C-k>"] = "move_cursor_up",
        },
      },
    },
  },

  ------------------
  -- Spaceless
  --
  -- Automatically strip trailing whitespace as you are editing.
  --
  -- https://github.com/lewis6991/spaceless.nvim
  ------------------
  {
    "lewis6991/spaceless.nvim",
    config = function()
      require("spaceless").setup()
    end,
  },

  ------------------
  -- Cinnamon Scroll 🌀
  --
  -- Smooth scrolling for ANY movement command 🤯. A Neovim plugin written in
  -- Lua!
  --
  -- https://github.com/declancm/cinnamon.nvim
  ------------------
  {
    "declancm/cinnamon.nvim",
    opts = {
      default_delay = 4,
    },
  },

  ------------------
  -- Zen Mode
  --
  -- 🧘 Distraction-free coding for Neovim
  --
  -- https://github.com/folke/zen-mode.nvim
  ------------------
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

  ------------------
  -- Nvim Notify
  --
  -- A fancy, configurable, notification manager for NeoVim
  --
  -- https://github.com/rcarriga/nvim-notify
  ------------------
  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end,
  },
}
