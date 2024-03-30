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
      {
        "s1n7ax/nvim-window-picker",
        name = "window-picker",
        event = "VeryLazy",
        version = "2.*",
        opts = {
          hint = "floating-big-letter",
        },
      },
    },
    opts = {
      filesystem = {
        bind_to_cwd = false, -- I like to keep my cwd unchanged
        hijack_netrw_behavior = "open_current",
        filtered_items = {
          visible = true,
          hide_hidden = false,
        },
        follow_current_file = {
          enabled = true,
        },
      },
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function()
            -- This effectively hides the cursor
            vim.cmd("highlight! Cursor blend=100")
            vim.opt_local.relativenumber = true
          end,
        },
        {
          event = "neo_tree_buffer_leave",
          handler = function()
            vim.cmd("highlight! Cursor blend=0")
          end,
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
    opts = {
      render = "wrapped-compact",
    },
    init = function()
      vim.notify = require("notify")
    end,
  },

  ------------------
  -- Tint
  --
  -- Dim inactive windows in Neovim using window-local highlight namespaces.
  --
  -- https://github.com/levouh/tint.nvim
  ------------------
  {
    "levouh/tint.nvim",
    -- enabled = false,
    opts = {
      tint_background_colors = false,
      window_ignore_function = function(winid)
        local bufid = vim.api.nvim_win_get_buf(winid)
        local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
        local floating = vim.api.nvim_win_get_config(winid).relative ~= ""

        -- Do not tint `terminal` or floating windows, tint everything else
        return buftype == "terminal" or floating
      end,
    },
  },

  ------------------
  -- Satellite (nvim >= 0.10)
  --
  -- Decorate scrollbar for Neovim
  --
  -- https://github.com/lewis6991/satellite.nvim
  ------------------
  {
    "lewis6991/satellite.nvim",
    enabled = false,
    config = function()
      require("satellite").setup()
    end,
  },

  ------------------
  -- Scrollview (nvim >= 0.6)
  --
  -- A Neovim plugin that displays interactive vertical scrollbars and signs.
  --
  -- https://github.com/dstein64/nvim-scrollview
  ------------------
  {
    "dstein64/nvim-scrollview",
  },
}
