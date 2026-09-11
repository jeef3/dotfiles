local repo = vim.fn.fnamemodify(vim.fn.expand("<sfile>:p"), ":h:h")
vim.opt.rtp:append(repo .. "/.config/nvim")
vim.fn.chdir(repo)

local captured
local original_snacks = _G.Snacks

_G.Snacks = {
  picker = {
    format = {
      file = function()
        return {
          { "icon ", "Icon" },
          { "result", "SnacksPickerFile", field = "file" },
        }
      end,
    },
    source = {},
  },
}

package.preload["snacks.picker.source.files"] = function()
  return {
    get_fd = function()
      return "fd"
    end,
  }
end
package.preload["snacks.picker.source.proc"] = function()
  return {
    proc = function(opts)
      captured = opts
      return opts
    end,
  }
end

local picker = require("snacks_scoped_picker").setup({
  icons = { files = "F", grep = "G", directories = "D" },
})

assert(picker._prompt_for("files") == " F  ")
assert(picker._prompt_for("grep") == " G  ")
assert(
  picker._prompt_for("files", repo .. "/.config")
    == " F  %*%#SnacksPickerScope#.config/ "
)

local scoped = {
  cwd = function()
    return repo .. "/.config"
  end,
}
local formatted = picker._format_scoped_file({ file = "init.lua" }, scoped)
assert(formatted[2][1] == "@")
assert(formatted[3].field == "file")

local unscoped = {
  cwd = function()
    return repo
  end,
}
formatted = picker._format_scoped_file({ file = "init.lua" }, unscoped)
assert(formatted[2].field == "file")

local context = {
  filter = { search = "needle" },
  cwd = function()
    return repo .. "/.config"
  end,
  opts = function(_, opts)
    return opts
  end,
}
picker._scoped_finder("files")(nil, context)
assert(captured.cmd == "fd")
assert(captured.cwd == repo .. "/.config")
local item = { text = "nvim/init.lua" }
captured.transform(item)
assert(item.cwd == repo .. "/.config")
assert(item.file == "nvim/init.lua")

picker._scoped_finder("grep")(nil, context)
assert(captured.cmd == "rg")
assert(captured.cwd == repo .. "/.config")
item = { text = "nvim/init.lua\00012:4:needle" }
captured.transform(item)
assert(item.file == "nvim/init.lua")
assert(vim.deep_equal(item.pos, { 12, 3 }))
assert(item.line == "needle")

local opened
_G.Snacks.picker.files = function(opts)
  opened = opts
end
picker.files()
assert(opened.prompt == " F  ")
assert(opened.title == "Files")

_G.Snacks.picker.grep = function(opts)
  opened = opts
end
picker.grep()
assert(opened.prompt == " G  ")
assert(opened.title == "Find in files")

package.preload["snacks.picker.core.finder"] = function()
  return {
    new = function(fn)
      return { fn = fn, abort = function() end }
    end,
  }
end

-- Regression test: live pickers (e.g. grep, bound to <C-p>) must have
-- opts.live disabled while browsing the directory-picker mode, since the
-- directories finder ignores the live search string. Otherwise typed input
-- keeps being routed to filter.search instead of filter.pattern and no
-- directories are ever matched/shown.
_G.Snacks.picker.config = {
  format = function()
    return function()
      return {}
    end
  end,
}
local mock_picker = {
  input = {
    get = function()
      return ""
    end,
    set = function() end,
    update = function() end,
  },
  finder = { abort = function() end },
  opts = { source = "grep", live = true },
  title = "Find in files",
  format = function() end,
  set_cwd = function() end,
  refresh = function() end,
}
opened.actions.pick_dir(mock_picker)
assert(mock_picker.opts.source == "directories")
assert(mock_picker.opts.live == false)

-- Confirming a directory selection must restore the original live flag
-- (true, for grep) so live search behaves normally again once back in
-- "search" mode.
_G.Snacks.picker.util = {
  path = function(item)
    return item.file
  end,
}
opened.actions.confirm(mock_picker, { file = repo }, "confirm")
assert(mock_picker.opts.source == "grep")
assert(mock_picker.opts.live == true)

_G.Snacks = original_snacks
print("snacks_scoped_picker: OK")
