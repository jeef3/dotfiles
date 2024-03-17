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
          win_options = { winblend = 20 },
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = 5,
            col = "50%",
          },
          size = {
            size = 60,
            height = 10,
          },
          border = { 1, 1 },
          win_options = { winblend = 20 },
        },
        mini = {
          position = {
            row = -2,
            col = "100%",
          },
        },
      },
      cmdline = {
        win_options = {
          winblend = 10,
        },
        format = {
          cmdline = {
            title = "",
            pattern = "^:",
            icon = " ",
            lang = "vim",
          },
        },
      },
      popupmenu = {
        backend = "nui",
      },
      messages = {
        enabled = false,
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
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = {
        presets = {
          operators = false,
          motions = false,
        },
      },
    },
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
  },
}
