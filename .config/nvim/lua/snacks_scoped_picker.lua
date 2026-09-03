local M = {}

local defaults = {
  icons = {
    directories = "",
    files = "",
    grep = "",
  },
}

local config = vim.deepcopy(defaults)

local function root()
  return vim.fs.normalize(vim.fn.getcwd())
end

local function prompt_for(kind, cwd)
  local prompt = " " .. config.icons[kind] .. "  "
  if not cwd then
    return prompt
  end

  cwd = vim.fs.normalize(cwd)
  if cwd == root() then
    return prompt
  end

  local relative = vim.fs.relpath(root(), cwd) or cwd
  return prompt .. "%*%#SnacksPickerScope#" .. relative .. "/ "
end

local function format_scoped_file(item, picker)
  local result = Snacks.picker.format.file(item, picker)
  if vim.fs.normalize(picker:cwd()) ~= root() then
    for index, part in ipairs(result) do
      if part.resolve or part.field == "file" then
        table.insert(result, index, { "@", "SnacksPickerScope" })
        break
      end
    end
  end
  return result
end

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

local function rescope(picker, state, cwd)
  picker:set_cwd(cwd)
  picker.opts.prompt = prompt_for(state.kind, cwd)
  picker.input:update()
  picker:refresh()
end

local function pick_dir(picker, state)
  if state.mode == "directories" then
    return
  end

  local fd = require("snacks.picker.source.files").get_fd()
  if not fd then
    return
  end

  local search_root = root()
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
          item.cwd = search_root
          item.file = item.text
          item.dir = true
        end,
      }),
      ctx
    )
    return function(cb)
      cb({ text = ".", file = search_root, dir = true })
      proc(cb)
    end
  end)

  picker.opts.source = "directories"
  picker.opts.prompt = " " .. config.icons.directories .. "  "
  picker.title = "Directories"
  picker.format = Snacks.picker.config.format({ format = "file" })
  picker:set_cwd(search_root)
  picker.input:set("", "")
  picker:refresh()
end

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

local function open(kind, cwd, text)
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
        if state.mode == "directories" then
          if picker.input:get() ~= "" then
            vim.api.nvim_feedkeys(vim.keycode("<bs>"), "in", false)
            return
          end
          resume_search(picker, state, root())
          return
        end
        if
          picker.input:get() ~= "" or vim.fs.normalize(picker:cwd()) == root()
        then
          vim.api.nvim_feedkeys(vim.keycode("<bs>"), "in", false)
          return
        end
        rescope(picker, state, root())
      end,
      confirm = function(picker, item, action)
        if state.mode == "directories" then
          resume_search(
            picker,
            state,
            item and Snacks.picker.util.path(item) or root()
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

function M.files(opts)
  opts = opts or {}
  open("files", opts.cwd, opts.pattern)
end

function M.grep(opts)
  opts = opts or {}
  open("grep", opts.cwd, opts.search)
end

function M.setup(opts)
  config = vim.tbl_deep_extend("force", vim.deepcopy(defaults), opts or {})
  return M
end

M._prompt_for = prompt_for
M._format_scoped_file = format_scoped_file
M._scoped_finder = scoped_finder

return M
