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

--- Build the input prompt, appending the directory the search is scoped to
local function prompt_for(kind, cwd)
  local prompt = " "
    .. (kind == "files" and "" or "")
    .. "  "
  if not cwd then
    return prompt
  end

  local root = vim.fs.normalize(vim.fn.getcwd())
  cwd = vim.fs.normalize(cwd)
  if cwd == root then
    return prompt
  end

  local relative = vim.fs.relpath(root, cwd) or cwd
  return prompt .. "%*%#SnacksPickerScope#" .. relative .. "/ "
end

local search

--- Pick a directory, then re-open the original picker scoped to it
local function pick_dir(kind, picker)
  local text = picker.input:get()
  local prev_cwd = picker:cwd()
  local root = vim.fs.normalize(vim.fn.getcwd())
  local fd = require("snacks.picker.source.files").get_fd()
  if not fd then
    return
  end

  picker:close()

  vim.schedule(function()
    local handled = false

    --- Close the directory picker and reopen the search scoped to `dir`
    local function resume(dir_picker, dir)
      handled = true
      dir_picker:close()
      vim.schedule(function()
        search(kind, dir, text)
      end)
    end

    Snacks.picker.pick({
      source = "directories",
      title = "Directories",
      prompt = " @ ",
      cwd = root,
      format = "file",
      preview = "none",
      actions = {
        unscope_dir = function(dir_picker)
          if dir_picker.input:get() ~= "" then
            vim.api.nvim_feedkeys(vim.keycode("<bs>"), "in", false)
            return
          end
          resume(dir_picker, root)
        end,
        cancel_dir = function(dir_picker)
          handled = true
          dir_picker:close()
        end,
      },
      win = {
        input = {
          keys = {
            ["<bs>"] = { "unscope_dir", mode = { "i" } },
            ["<esc>"] = { "cancel_dir", mode = { "n", "i" } },
          },
        },
      },
      finder = function(_, ctx)
        local proc = require("snacks.picker.source.proc").proc(
          ctx:opts({
            cmd = fd,
            args = {
              "--type",
              "d",
              "--color",
              "never",
              "--hidden",
              "-E",
              ".git",
            },
            transform = function(item)
              item.cwd = root
              item.file = item.text
              item.dir = true
            end,
          }),
          ctx
        )
        return function(cb)
          cb({ text = ".", file = root, dir = true })
          proc(cb)
        end
      end,
      confirm = function(dir_picker, item)
        resume(dir_picker, item and Snacks.picker.util.path(item) or root)
      end,
      on_close = function()
        if handled then
          return
        end
        vim.schedule(function()
          search(kind, prev_cwd, text)
        end)
      end,
    })
  end)
end

--- Open a files/grep picker, optionally scoped to a directory
---@param kind "files"|"grep"
function search(kind, cwd, text)
  local opts = {
    hidden = true,
    prompt = prompt_for(kind, cwd),
    cwd = cwd,
    actions = {
      pick_dir = function(picker)
        if picker.input:get() ~= "" then
          vim.api.nvim_feedkeys("@", "in", false)
          return
        end
        pick_dir(kind, picker)
      end,
      unscope_dir = function(picker)
        local root = vim.fs.normalize(vim.fn.getcwd())
        if picker.input:get() ~= "" or vim.fs.normalize(picker:cwd()) == root then
          vim.api.nvim_feedkeys(vim.keycode("<bs>"), "in", false)
          return
        end

        local text = picker.input:get()
        picker:close()
        vim.schedule(function()
          search(kind, root, text)
        end)
      end,
    },
    win = {
      input = {
        keys = {
          ["@"] = { "pick_dir", mode = { "i" } },
          ["<bs>"] = { "unscope_dir", mode = { "i" } },
        },
      },
    },
  }

  if kind == "files" then
    opts.title = "Files"
    opts.pattern = text
    Snacks.picker.files(opts)
  else
    opts.title = "Find in files"
    opts.search = text
    Snacks.picker.grep(opts)
  end
end

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
          search("files")
        end,
        desc = "Find files",
      },
      {
        "<C-p>",
        function()
          search("grep")
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
