--------------------------------
-- UI
--
-- Plugins that enhance the overall UI of Vim in a more superficial way.
--------------------------------

return {
  ----------------
  -- Noice
  --
  -- 💥Highly experimental plugin that completely replaces the UI for messages,
  -- cmdline and the popupmenu.
  --
  -- https://github.com/folke/noice.nvim
  ----------------
  {
    enabled = false,
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      views = {
        cmdline_popup = {
          position = {
            row = 3,
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
          border = {
            style = "none",
            padding = { 1, 3 },
          },
          win_options = {},
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = 7,
            col = "50%",
          },
          size = {
            size = 64,
            height = 10,
          },
          border = {
            style = "none",
            padding = { 3, 6 },
          },
        },
        mini = {
          position = {
            row = -2,
            col = "100%",
          },
        },
      },
      cmdline = {
        format = {
          cmdline = {
            title = "",
            pattern = "^:",
            icon = " ",
            lang = "vim",
          },
          search_down = {
            title = "",
          },
        },
      },
      popupmenu = {
        backend = "nui",
      },
      messages = {
        enabled = false,
        view_search = false,
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        lsp_doc_border = true,
      },
      lsp = {
        progress = {
          enabled = true,
          format = "lsp_progress_done",
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        signature = {
          auto_open = { enabled = false },
        },
      },
      routes = {
        -- Avoid written messages
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
        -- Avoid search messages
        {
          filter = {
            event = "msg_show",
            kind = "search_count",
          },
          opts = { skip = true },
        },
        -- -- Avoid all messages of ""
        {
          filter = {
            event = "msg_show",
            kind = "",
          },
          opts = { skip = true },
        },
      },
    },
  },

  ------------------
  -- Vimade
  --
  -- Vimade let's you dim, fade, tint, animate, and customize colors in your
  -- windows and buffers for (Neo)vim
  --
  -- https://github.com/TaDaa/vimade
  ------------------
  {
    "tadaa/vimade",
    enabled = true,
    opts = {
      recipe = { "default", { animate = true } },
      fadelevel = 0.6,
    },
  },

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
    config = {
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
