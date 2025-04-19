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
      win = {
        wo = {
          winblend = 10,
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
      options = {
        delay = 4,
      },
    },
    init = function()
      local cinnamon = require("cinnamon")

      vim.keymap.set("n", "<c-u>", function()
        cinnamon.scroll("<c-u>")
      end)
      vim.keymap.set("n", "<c-d>", function()
        cinnamon.scroll("<c-d>")
      end)
    end,
  },

  ------------------
  -- Twilight
  --
  -- 🌅 Twilight is a Lua plugin for Neovim 0.5 that dims inactive portions of
  -- the code you're editing using TreeSitter.
  --
  -- https://github.com/folke/twilight.nvim
  ------------------
  {
    "folke/twilight.nvim",
    cmd = { "Twilight" },
    opts = {},
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
    dependencies = {
      "folke/twilight.nvim",
    },
    cmd = { "ZenMode" },
    opts = {
      window = { width = 90, height = 0.75 },
      plugins = {
        tmux = { enabled = true },
        twilight = { enabled = true },
        kitty = { enabled = true, font = "+4" },
      },
    },
    on_open = function()
      vim.opt.wrap = true
    end,
    on_close = function()
      vim.opt.wrap = false
    end,
  },
}
