local wz = require("wezterm")
local tabline =
  wz.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

local function basename(s)
  return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local function window_cwd(window)
  local cwd
  local pane = window:active_pane()
  local cwd_uri = pane:get_current_working_dir()
  if cwd_uri then
    local file_path = cwd_uri.file_path
    cwd = file_path:match("([^/]+)/?$")
    if cwd and #cwd > 10 then
      cwd = cwd:sub(1, 10 - 1) .. "…"
    end
  end
  return "   " .. cwd .. " "
end

local function window_git(window)
  return "   main "
end

local function window_process(window)
  local pane = window:active_pane()
  local name = pane:get_foreground_process_name()

  return " " .. basename(name) .. " "
end

tabline.setup({
  options = {
    section_separators = {
      left = "",
      right = "",
    },
    component_separators = "",
    tab_separators = "",
  },

  sections = {
    tabline_a = { "window" },
    tabline_b = {},
    tabline_c = {},

    tab_active = {
      "index",
      { "tab", icons_enabled = false },
    },

    tab_inactive = {
      "index",
      { "tab", icons_enabled = false },
    },

    tabline_x = { window_process },
    tabline_y = { window_git },
    tabline_z = { window_cwd },
  },
})
