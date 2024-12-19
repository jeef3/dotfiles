local wezterm = require("wezterm")
local tabline =
  wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

local c = require("colors")
local window_process = require("components.process")
local window_git = require("components.git")
local window_cwd = require("components.cwd")

local tmux = {
  "tmux",
  events = {
    show = "tmux_plugin.show",
    hide = "tmux_plugin.hide",
    callback = function(window)
      wezterm.log_info("CALLBACK")
    end,
  },
  sections = {
    tabline_a = { "LEAD" },
  },
  colors = {
    a = { bg = c.orange },
  },
}

local function test_fn(window)
  local kt = window:active_key_table()

  if kt == nil then
    return "  "
  elseif kt == "tmux" then
    return "  "
  else
    return kt
  end
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
local M = {}

function M.setup(_)
  tabline.setup({
    options = {
      section_separators = {
        left = "",
        right = "",
      },
      component_separators = "",
      tab_separators = {
        left = "",
        right = "|",
      },

      color_overrides = {
        -- normal_mode = {
        --   a = { fg = c.silver_300, bg = c.silver_800 },
        --   b = { fg = c.silver_200, bg = c.silver_600 },
        --   c = { fg = c.silver_200, bg = c.silver_800 },
        --   z = { fg = c.silver_100, bg = c.pink_600 },
        --   y = { fg = c.silver_200, bg = c.silver_600 },
        --   x = { fg = c.silver_200, bg = c.silver_800 },
        -- },
        tab = {
          active = { fg = c.silver_100, bg = c.silver_500 },
          inactive = { fg = c.silver_300, bg = c.silver_800 },
          inactive_hover = {},
        },
        tmux_mode = {
          a = { fg = c.silver_300, bg = c.pink },
          b = { fg = c.silver_200, bg = c.silver_600 },
          c = { fg = c.silver_200, bg = c.silver_800 },
          z = { fg = c.silver_100, bg = c.pink_600 },
          y = { fg = c.silver_200, bg = c.silver_600 },
          x = { fg = c.silver_200, bg = c.silver_800 },
        },
      },
    },

    sections = {
      tabline_a = {
        test_fn,
      },
      tabline_b = { "workspace" },
      tabline_c = {},

      tab_active = {
        { "zoomed" },
        { "tab", icons_enabled = false },
      },

      tab_inactive = {
        { "zoomed" },
        { "tab", icons_enabled = false },
      },

      tabline_x = { window_process },
      tabline_y = { window_git },
      tabline_z = { window_cwd },
    },

    extensions = { "resurrect" },
  })
end

return M
