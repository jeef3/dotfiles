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
        "<leader>e",
        "<cmd>lua Snacks.picker.explorer()<CR>",
        desc = "File Explorer",
      },
      {
        "<leader><space>",
        "<cmd>lua Snacks.picker.lines()<CR>",
        desc = "Buffer lines",
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
            backdrop = false, -- Vimade does this for me
            row = 4,
            width = 0.4,
            min_width = 80,
            height = 0.8,
            max_height = 20,
            border = false,
            box = "vertical",
            {
              -- max_height = 15,
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
              title = "{title}",
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
            -- {
            --   box = "vertical",
            --   auto_hide = true,
            --   row = 1,
            --   border = {
            --     "🬕",
            --     "🬂",
            --     "🬨",
            --     "▐",
            --     "🬷",
            --     "🬭",
            --     "🬲",
            --     "▌",
            --   },
            --   title = "Preview",
            --   title_pos = "center",
            --   {
            --     win = "preview",
            --   },
            -- },
          },
        },
      },

      -- explorer = {}, -- Replaces netrw

      lazygit = {
        win = {
          position = "float",
        },
      },
    },
  },
}
