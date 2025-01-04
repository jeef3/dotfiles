local wezterm = require("wezterm")
local c = require("colors")
local appearance = require("appearance")

local princess = require("princess")

local config = wezterm.config_builder()
config.keys = {}

require("plugins.tmux").setup(config)
require("plugins.resurrect").setup(config)
require("plugins.workspace_switcher").setup(config)
require("plugins.tabline").setup(config)

config.default_workspace = "~"
config.status_update_interval = 200
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.enable_scroll_bar = false

config.command_palette_rows = 10
config.command_palette_font_size = 19
config.command_palette_fg_color = c.silver_300
config.command_palette_bg_color = c.silver_800

config.default_cursor_style = "BlinkingUnderline"
config.cursor_blink_rate = 600
config.cursor_thickness = 3

config.color_schemes =
  { ["Princess Light"] = princess.light, ["Princess Dark"] = princess.dark }
config.color_scheme = "Princess Dark"

config.font_size = 17
config.font = wezterm.font({
  family = "OperatorMonoLig Nerd Font",
  weight = "Book",
})
config.font_rules = {
  {
    intensity = "Bold",
    italic = false,
    font = wezterm.font("OperatorMonoSsmLig Nerd Font", { weight = "Bold" }),
  },
  {
    intensity = "Bold",
    italic = true,
    font = wezterm.font(
      "OperatorMonoSsmLig Nerd Font",
      { weight = "Bold", italic = true }
    ),
  },
}

config.window_frame = {
  border_left_width = 0,
  border_right_width = 0,
  border_bottom_height = 0,
  border_top_height = 0,
}

config.window_padding = {
  top = 0,
  right = 0,
  bottom = 0,
  left = 0,
}

if appearance.is_dark() then
  config.color_scheme = "Princess Dark"
else
  -- config.color_scheme = "Princess Light"
  config.color_scheme = "Princess Dark"
end

wezterm.on("window-config-reloaded", function(window, pane)
  window:toast_notification("wezterm", "configuration reloaded!", nil, 4000)
end)
-- wezterm.plugin.update_all()

return config
