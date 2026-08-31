----------------
-- Snacks
--
-- 🍿 A collection of QoL plugins for Neovim
--
-- https://github.com/folke/snacks.nvim
----------------

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
        function()
          Snacks.lazygit()
        end,
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
        on_change = function(picker, item)
          local path = ""
          if item and item.file then
            path = vim.fs.relpath(picker:cwd(), item.file) or item.file
          end
          local box = picker.layout.box_wins[3]
          if box and box.win then
            vim.api.nvim_win_set_config(box.win, {
              footer = path ~= ""
                  and { { " " .. path .. " ", "SnacksPickerFooter" } }
                or "",
              footer_pos = "center",
            })
          end
        end,
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
              {
                box = "vertical",
                height = 1,
                border = { "", "", "", " ", " ", " ", " ", " " },
              },
            },
          },
        },
      },

      lazygit = {},

      image = {},

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

      input = {
        icon = "󰑕 ",
        icon_pos = "left",
        prompt_pos = "title",
        win = { style = "input", relative = "cursor", row = 1, width = 20 },
        expand = true,
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
