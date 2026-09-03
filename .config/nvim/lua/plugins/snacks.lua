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
  local prompt = " " .. (kind == "files" and "" or "") .. "  "
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

--- Prefix scoped results without changing their file paths or match positions.
local function format_scoped_file(item, picker)
  local result = Snacks.picker.format.file(item, picker)
  local root = vim.fs.normalize(vim.fn.getcwd())
  if vim.fs.normalize(picker:cwd()) ~= root then
    for index, part in ipairs(result) do
      if part.resolve or part.field == "file" then
        table.insert(result, index, { "@", "SnacksPickerScope" })
        break
      end
    end
  end
  return result
end

--- Build a finder which executes within the picker cwd. Snacks' built-in
--- finders inherit Neovim's cwd, which is wrong after an in-place re-scope.
local function scoped_finder(kind)
  if kind == "files" then
    return function(_, ctx)
      return require("snacks.picker.source.proc").proc(
        ctx:opts({
          cmd = require("snacks.picker.source.files").get_fd(),
          args = {
            "--type",
            "f",
            "--type",
            "l",
            "--color",
            "never",
            "--hidden",
            "-E",
            ".git",
          },
          cwd = ctx:cwd(),
          transform = function(item)
            item.cwd = ctx:cwd()
            item.file = item.text
          end,
        }),
        ctx
      )
    end
  end

  return function(_, ctx)
    local search = ctx.filter.search
    if search == "" then
      return function() end
    end
    return require("snacks.picker.source.proc").proc(
      ctx:opts({
        cmd = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--glob=!.git",
          "--hidden",
          "-0",
          "--",
          search,
        },
        cwd = ctx:cwd(),
        notify = false,
        transform = function(item)
          local file, line, col, text =
            item.text:match("^(.-)%z(%d+):(%d+):(.*)$")
          if not (file and line and col and text) then
            return false
          end
          item.cwd = ctx:cwd()
          item.file = file
          item.pos = { tonumber(line), tonumber(col) - 1 }
          item.line = text
        end,
      }),
      ctx
    )
  end
end

--- Re-scope an already-open files/grep picker without recreating its windows.
local function rescope(picker, state, cwd)
  picker:set_cwd(cwd)
  picker.opts.prompt = prompt_for(state.kind, cwd)
  picker.input:update()
  picker:refresh()
end

--- Turn the active picker into a directory picker. Snacks permits only one
--- picker per tab, so replacing its finder preserves the existing UI.
local function pick_dir(picker, state)
  if state.mode == "directories" then
    return
  end

  local fd = require("snacks.picker.source.files").get_fd()
  if not fd then
    return
  end

  local root = vim.fs.normalize(vim.fn.getcwd())
  state.mode = "directories"
  state.source = picker.opts.source
  state.title = picker.title
  state.format = picker.format

  picker.finder:abort()
  picker.finder = require("snacks.picker.core.finder").new(function(_, ctx)
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
  end)

  picker.opts.source = "directories"
  picker.opts.prompt = "   "
  picker.title = "Directories"
  picker.format = Snacks.picker.config.format({ format = "file" })
  picker:set_cwd(root)
  picker.input:set("", "")
  picker:refresh()
end

--- Restore the original finder and apply the chosen directory as the scope.
local function resume_search(picker, state, cwd)
  picker.finder:abort()
  picker.finder =
    require("snacks.picker.core.finder").new(scoped_finder(state.kind))
  picker.opts.source = state.source
  picker.title = state.title
  picker.format = state.format
  state.mode = "search"
  picker.input:set("", "")
  rescope(picker, state, cwd)
end

--- Open a files/grep picker, optionally scoped to a directory
---@param kind "files"|"grep"
local function search(kind, cwd, text)
  local state = { kind = kind, mode = "search" }
  local opts = {
    hidden = true,
    prompt = prompt_for(kind, cwd),
    cwd = cwd,
    format = format_scoped_file,
    actions = {
      pick_dir = function(picker)
        if picker.input:get() ~= "" then
          vim.api.nvim_feedkeys("@", "in", false)
          return
        end
        pick_dir(picker, state)
      end,
      unscope_dir = function(picker)
        local root = vim.fs.normalize(vim.fn.getcwd())
        if state.mode == "directories" then
          if picker.input:get() ~= "" then
            vim.api.nvim_feedkeys(vim.keycode("<bs>"), "in", false)
            return
          end
          resume_search(picker, state, root)
          return
        end
        if
          picker.input:get() ~= "" or vim.fs.normalize(picker:cwd()) == root
        then
          vim.api.nvim_feedkeys(vim.keycode("<bs>"), "in", false)
          return
        end

        rescope(picker, state, root)
      end,
      confirm = function(picker, item, action)
        if state.mode == "directories" then
          resume_search(
            picker,
            state,
            item and Snacks.picker.util.path(item) or vim.fn.getcwd()
          )
          return
        end
        return require("snacks.picker.actions").confirm(picker, item, action)
      end,
      escape = function(picker)
        if state.mode == "directories" then
          picker:close()
          return
        end
        require("snacks.picker.actions").cancel(picker)
      end,
    },
    win = {
      input = {
        keys = {
          ["@"] = { "pick_dir", mode = { "i" } },
          ["<bs>"] = { "unscope_dir", mode = { "i" } },
          ["<esc>"] = { "escape", mode = { "n", "i" } },
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
