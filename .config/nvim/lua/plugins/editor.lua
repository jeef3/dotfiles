--------------------------------
-- Editor
--
-- Plugins that alter the general editing experience in Vim. Separate from any
-- UI enhancing plugins
--------------------------------

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

  ----------------
  -- Which Key
  --
  -- 💥 Create key bindings that stick. WhichKey is a lua plugin for Neovim 0.5
  -- that displays a popup with possible keybindings of the command you started
  -- typing.
  --
  -- https://github.com/folke/which-key.nvim
  ----------------
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = {
        presets = {
          operators = false,
          motions = false,
          windows = false,
        },
      },
      icons = {
        group = "",
      },
      window = {
        winblend = 10,
      },
    },
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
  },

  ------------------
  -- Lastplace
  --
  -- A Lua rewrite of vim-lastplace: A vim/nvim plugin that intelligently
  -- reopens files at your last edit position.
  --
  -- https://github.com/ethanholz/nvim-lastplace?tab=readme-ov-file
  ------------------
  { "ethanholz/nvim-lastplace" },

  ------------------
  -- Spaceless
  --
  -- Automatically strip trailing whitespace as you are editing.
  --
  -- https://github.com/lewis6991/spaceless.nvim
  ------------------
  { "lewis6991/spaceless.nvim" },

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
    cmd = { "ZenMode" },
    opts = {
      window = { width = 90 },
      plugins = {
        tmux = { enabled = true },
        kitty = { enabled = true, font = "+4" },
      },
    },
  },
}
