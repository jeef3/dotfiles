----------------
-- Snacks
--
-- 🍿 A collection of QoL plugins for Neovim
--
-- https://github.com/folke/snacks.nvim
----------------

local package_names = {}

local function package_for_file(file, cwd)
  if not vim.fs.relpath(cwd, file) then
    return
  end

  local package_json = vim.fs.find("package.json", {
    path = vim.fs.dirname(file),
    upward = true,
    stop = cwd,
  })[1]
  if not package_json then
    return
  end

  if package_names[package_json] == nil then
    local package =
      vim.json.decode(table.concat(vim.fn.readfile(package_json), "\n"))
    package_names[package_json] = package.name or false
  end

  local name = package_names[package_json]
  return name and { name = name, root = vim.fs.dirname(package_json) } or nil
end

local scoped_picker = require("snacks_scoped_picker").setup({
  icons = {
    directories = "",
    files = "",
    grep = "",
  },
})

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
          scoped_picker.files()
        end,
        desc = "Find files",
      },
      {
        "<C-p>",
        function()
          scoped_picker.grep()
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
          local footer = {}
          if item and item.file then
            local file = item.file
            if file:sub(1, 1) ~= "/" then
              file = vim.fs.joinpath(picker:cwd(), file)
            end

            local package = package_for_file(file, picker:cwd())
            local path = vim.fs.relpath(
              package and package.root or picker:cwd(),
              file
            ) or file
            local directory = vim.fs.dirname(path)
            if package then
              footer[#footer + 1] =
                { " " .. package.name, "SnacksPickerPackage" }
            end
            if directory ~= "." then
              footer[#footer + 1] = { " " .. directory, "SnacksPickerFooter" }
            end
            -- Display file name
            -- footer[#footer + 1] = { " " .. vim.fs.basename(path) .. " ", "SnacksPickerFooter" }
          end
          local box = picker.layout.box_wins[3]
          if box and box.win then
            vim.api.nvim_win_set_config(box.win, {
              footer = #footer > 0 and footer or "",
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
