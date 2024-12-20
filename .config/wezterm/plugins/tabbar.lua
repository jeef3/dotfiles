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
        left = "",
        right = "|",
      },

      color_overrides = {
        normal_mode = {
          a = { fg = c.silver_300, bg = c.silver_800 },
          b = { fg = c.silver_200, bg = c.silver_600 },
          c = { fg = c.silver_200, bg = c.silver_800 },
          x = { fg = c.silver_300, bg = c.silver_800 },
          y = { fg = c.silver_200, bg = c.silver_600 },
          z = { fg = c.silver_100, bg = c.pink_600 },
        },
        tab = {
          active = { fg = c.silver_100, bg = c.silver_500 },
          inactive = { fg = c.silver_300, bg = c.silver_800 },
          inactive_hover = {},
        },
        tmux_mode = {
          a = { fg = c.silver_800, bg = c.orange },
          b = { fg = c.silver_200, bg = c.silver_600 },
          c = { fg = c.silver_200, bg = c.silver_800 },
          x = { fg = c.silver_300, bg = c.silver_800 },
          y = { fg = c.silver_200, bg = c.silver_600 },
          z = { fg = c.silver_900, bg = c.orange },
        },
      },
    },

    sections = {
      tabline_a = { "mode" },
      -- tabline_b = { { "workspace", icons_enabled = false } },
      tabline_b = {},
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

    extensions = { "resurrect", "smart_workspace_switcher", tmux },
  })

  tabline.apply_to_config(config)
end

return M
