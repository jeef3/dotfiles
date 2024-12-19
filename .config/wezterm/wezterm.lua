local wezterm = require("wezterm")
local appearance = require("appearance")

local princess = require("princess")

local config = wezterm.config_builder()
config.keys = {}
config.key_tables = { tmux_mode = {} }

require("plugins.resurrect").setup(config)
require("plugins.tabbar").setup(config)
require("plugins.tmux").setup(config)

config.status_update_interval = 500

config.enable_scroll_bar = false

config.command_palette_rows = 10
config.command_palette_font_size = 17

config.color_schemes = { ["Princess"] = princess }
config.color_scheme = "Princess"

config.font = wezterm.font("Operator Mono")
-- config.font = wz.font("OperatorMonoLig Nerd Font")
config.font_rules = {
  {
    intensity = "Bold",
    italic = false,
    font = wezterm.font("OperatorMonoSSmLig Nerd Font"),
  },
  {
    intensity = "Bold",
    italic = true,
    font = wezterm.font("OperatorMonoSSmLig Nerd Font", { italic = true }),
  },
}
config.font_size = 17

config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.window_frame = {
  border_left_width = 0,
  border_right_width = 0,
  border_bottom_height = 0,
  border_top_height = 0,

  -- active_titlebar_bg = c.silver_900,

  font = wezterm.font({ family = "Operator Mono" }),
  font_size = 17,
}

config.window_padding = {
  top = 0,
  right = 0,
  bottom = 0,
  left = 0,
}

-- if appearance.is_dark() then
--   config.color_scheme = "Mocha (dark) (terminal.sexy)"
-- else
--   config.color_scheme = "Mocha (light) (terminal.sexy)"
-- end

return config
