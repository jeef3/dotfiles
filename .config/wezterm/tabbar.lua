local wz = require("wezterm")
local tabline =
  wz.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

local c = require("colors")

local function basename(s)
  if s then
    return string.gsub(s, "(.*[/\\])(.*)", "%2")
  else
    return ""
  end
end

local tmux = {
  "tmux",
  events = {
    show = "tmux_plugin.show",
    hide = "tmux_plugin.hide",
    callback = function(window)
      wz.log_info("CALLBACK")
    end,
  },
  sections = {
    tabline_a = { "LEAD" },
  },
  colors = {
    a = { bg = c.orange },
  },
}

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
  else
    cwd = "."
  end
  return "   " .. cwd .. " "
end

local function window_git(window)
  return "   main "
end

local function window_process(window)
  local pane = window:active_pane()
  if pane then
    local name = pane:get_foreground_process_name()
    return " " .. basename(name) .. " "
  end

  return " . "
end

local function window_leader(window)
  if window:leader_is_active() then
    return "    "
    -- return {
    --   { Text = "   " },
    --   { Foreground = { Color = c.silver_900 } },
    --   { Background = { Color = c.orange } },
    --   { Text = "" },
    --   { Attribute = { Intensity = "Bold" } },
    --   { Foreground = { Color = c.silver_800 } },
    --   { Background = { Color = c.orange } },
    --   { Text = "  " },
    --   { Foreground = { Color = c.orange } },
    --   { Background = { Color = c.silver_900 } },
    --   { Text = "" },
    -- }
  else
    return "    "
    -- return {
    --   { Text = "   " },
    --   { Foreground = { Color = c.silver_900 } },
    --   { Background = { Color = c.silver_800 } },
    --   { Text = "" },
    --   { Attribute = { Intensity = "Bold" } },
    --   { Foreground = { Color = c.silver_400 } },
    --   { Background = { Color = c.silver_800 } },
    --   { Text = "  " },
    --   { Foreground = { Color = c.silver_800 } },
    --   { Background = { Color = c.silver_900 } },
    --   { Text = "" },
    -- }
  end
end

tabline.setup({
  options = {
    section_separators = {
      left = "",
      right = "",
    },
    component_separators = "",
    tab_separators = "",

    color_overrides = {
      normal_mode = {
        a = { fg = c.silver_300, bg = c.silver_800 },
        b = { fg = c.silver_200, bg = c.silver_600 },
        c = { fg = c.silver_200, bg = c.silver_800 },
        z = { fg = c.silver_100, bg = c.pink_600 },
        y = { fg = c.silver_200, bg = c.silver_600 },
        x = { fg = c.silver_200, bg = c.silver_800 },
      },
      tab = {
        active = { fg = c.silver_100, bg = c.silver_500 },
        inactive = { fg = c.silver_300, bg = c.silver_800 },
        inactive_hover = {},
      },
      tmux_mode = {
        a = { fg = "red", bg = "blue" },
      },
    },
  },

  sections = {
    tabline_a = {
      "mode",
    },
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

    tabline_x = {},
    tabline_y = { window_process, window_git },
    tabline_z = { window_cwd },
  },

  extensions = { "resurrect" },
})
