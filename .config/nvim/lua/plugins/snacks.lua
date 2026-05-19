return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    enabled = true,
    keys = {
      {
        "<C-t>",
        function()
          Snacks.picker.files({
            title = "Files",
            hidden = true,
            prompt = "   ",
          })
        end,
        desc = "Find files",
      },
      {
        "<C-p>",
        function()
          Snacks.picker.grep({
            title = "Find in files",
            hidden = true,
            prompt = "   ",
          })
        end,
        desc = "Find in files",
      },
      {
        "<leader>gl",
        "<cmd>lua Snacks.lazygit()<cr>",
        desc = "Open LazyGit",
      },
    },

    --- @module "snacks"
    --- @type snacks.Config
    opts = {
      bigfile = { enabled = true },

      notifier = {
        enabled = true,
        timeout = 3000,
      },

      picker = {
        notify = { enabled = true },
        input = {
          prompt = "   ",
          hidden = true,
        },
        win = {
          input = {
            keys = {
              ["<esc>"] = { "close", mode = { "n", "i" } },
            },
          },
        },
        layout = {
          layout = {
            row = 4,
            width = 0.7,
            min_width = 50,
            height = 0.8,
            max_height = 20,
            border = false,
            box = "vertical",
            {
              box = "vertical",
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
              title = "  {title}",
              title_pos = "center",
              {
                win = "input",
                height = 1,
                border = { "", "", "", " ", " ", "▁", " ", " " },
              },
              {
                win = "list",
                border = { " ", " ", " ", " ", "", "", "", " " },
              },
            },
          },
        },
      },

      lazygit = {
        win = {
          position = "float",
        },
      },

      indent = {
        indent = {
          char = "┊",
          only_current = true,
        },
        chunk = {
          enabled = true,
          char = {
            corner_top = "╭",
            corner_bottom = "╰",
            horizontal = "─",
            vertical = "┊",
            arrow = "►",
          },
        },
      },

      words = { enabled = true },

      scroll = {
        enabled = true,
        animate = {
          duration = { step = 8, total = 200 },
          easing = "inOutCubic",
        },
      },
    },
  },
}
