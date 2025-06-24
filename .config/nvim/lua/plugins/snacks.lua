return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = true,
    enabled = true,
    keys = {
      {
        "<C-t>",
        "<cmd>lua Snacks.picker.files({ title = 'Find', hidden = true })<CR>",
        desc = "Smart Find Files",
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

      picker = {
        win = {
          input = {
            keys = {
              ["<esc>"] = { "close", mode = { "n", "i" } },
            },
          },
        },
        layout = {
          layout = {
            backdrop = false,
            row = 3,
            width = 0.4,
            min_width = 80,
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
              title = "{title}",
              title_pos = "center",
              { win = "input", height = 1, border = "solid" },
              { win = "list", border = "none" },
            },
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
