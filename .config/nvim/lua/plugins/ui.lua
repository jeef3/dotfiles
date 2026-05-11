--------------------------------
-- UI
--
-- Plugins that enhance the overall UI of Vim in a more superficial way.
--------------------------------

return {
  ------------------
  -- Windows
  --
  -- Automatically expand width of the current window. Maximizes and restore it.
  -- And all this with nice animations!
  --
  -- https://github.com/anuvyklack/windows.nvim
  ------------------
  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    opts = {
      autowidth = {
        winwidth = 7, -- 6 characer gutter and 1 character pad
      },
      ignore = {
        buftype = { "nofile" },
        filetype = { "neotest-summary" },
      },
    },
    init = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
    end,
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
    enabled = true,
    config = function()
      require("satellite").setup({
        current_only = true,
        handlers = {
          gitsigns = { enable = false },
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
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { focusable = false })
      end,
    },
    init = function()
      vim.notify = require("notify")
    end,
  },

  ------------------
  -- Netrw
  --
  -- It's not because we use netrw that we cannot have nice things!
  --
  -- https://github.com/prichrd/netrw.nvim
  ------------------
  {
    "prichrd/netrw.nvim",
    config = true,
  },
}
