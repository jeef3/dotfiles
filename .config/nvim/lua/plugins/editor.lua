--------------------------------
-- Editor
--
-- Plugins that alter the general editing experience in Vim. Separate from any
-- UI enhancing plugins
--------------------------------

return {
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
      preset = "helix",
      plugins = {
        presets = {
          operators = false,
          motions = false,
          windows = false,
        },
      },
      icons = {
        group = "",
        separator = "│",
      },
      win = {
        wo = {
          winblend = 30,
        },
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
  -- Zen Mode
  --
  -- 🧘 Distraction-free coding for Neovim
  --
  -- https://github.com/folke/zen-mode.nvim
  ------------------
  {
    "folke/zen-mode.nvim",
    dependencies = {
      "folke/twilight.nvim",
    },
    cmd = { "ZenMode" },
    opts = {
      window = { width = 90, height = 0.75 },
      plugins = {
        tmux = { enabled = true },
        twilight = { enabled = true },
        -- kitty = { enabled = true, font = "+4" },
      },
    },
    on_open = function()
      vim.opt.wrap = true
    end,
    on_close = function()
      vim.opt.wrap = false
    end,
  },

  {
    "lewis6991/hover.nvim",
    config = {
      --- @type (string|Hover.Config.Provider)[]
      providers = {
        "hover.providers.lsp",
        "hover.providers.dap",
      },
      preview_opts = {
        border = {
          "🬕",
          "🬂",
          "🬨",
          "▐",
          "🬷",
          "🬭",
          "🬲",
          "▌",
        },
      },
      preview_window = true,
    },
  },
}
