local wezterm = require("wezterm")
local tabline =
  wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

local c = require("config.colors")

local window_process = require("components.process")
local window_git = require("components.git")
local window_cwd = require("components.cwd")

local tmux = {
  "tmux",
  events = {
    show = "tmux_mode.active",
    hide = {
      "tmux_mode.inactive",
      "smart_workspace_switcher.workspace_switcher.chosen",
      "smart_workspace_switcher.workspace_switcher.canceled",
      "smart_workspace_switcher.workspace_switcher.created",
    },
  },
  sections = {
    tabline_a = { "   " },
    -- tabline_b = {},
    tabline_b = { { "workspace", icons_enabled = false } },
    tabline_c = {},

    tab_active = {
      { "index" },
      { "tab", icons_enabled = false },
      { "zoomed" },
    },

    tab_inactive = {
      { "index" },
      { "tab", icons_enabled = false },
      { "zoomed" },
    },
    tabline_x = {},
    tabline_y = {},
    tabline_z = {},
  },
  theme = {
    a = { fg = c.silver_800, bg = c.orange_500 },
    b = { fg = c.silver_200, bg = c.silver_600 },
    c = { fg = c.silver_200, bg = c.silver_800 },
    x = { fg = c.silver_300, bg = c.silver_800 },
    y = { fg = c.silver_200, bg = c.silver_600 },
    z = { fg = c.silver_900, bg = c.orange_500 },
  },
}

local M = {}

function M.setup(config)
  tabline.setup({
    options = {
      section_separators = {
        left = "",
        right = "",
      },
      component_separators = "",
      tab_separators = {
        left = "",
        right = "",
      },

      theme_overrides = {
        normal_mode = {
          a = { fg = c.silver_300, bg = c.silver_800 },
          b = { fg = c.silver_200, bg = c.silver_600 },
          c = { fg = c.silver_200, bg = c.silver_800 },
          x = { fg = c.silver_300, bg = c.silver_800 },
          y = { fg = c.silver_200, bg = c.silver_600 },
          z = { fg = c.silver_100, bg = c.pink_500 },
        },
        tab = {
          active = { fg = c.silver_100, bg = c.silver_500 },
          inactive = { fg = c.silver_300, bg = c.silver_800 },
          inactive_hover = { fg = c.silver_200, bg = c._cilver_600 },
        },
        tmux_mode = {},
      },
    },

    sections = {
      tabline_a = { "    " },
      tabline_b = { { "workspace", icons_enabled = false } },
      -- tabline_b = {},
      tabline_c = {},

      tab_active = {
        { "tab", icons_enabled = false },
        { "zoomed" },
      },

      tab_inactive = {
        { "tab", icons_enabled = false },
        { "zoomed" },
      },

      tabline_x = { window_process },
      tabline_y = { window_git },
      tabline_z = { window_cwd },
    },

    extensions = { "resurrect", "smart_workspace_switcher", tmux },
  })

  tabline.apply_to_config(config)
end

return M
