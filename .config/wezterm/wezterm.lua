local wezterm = require("wezterm")
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
config.command_palette_font_size = 17

config.color_schemes = { ["Princess"] = princess }
config.color_scheme = "Princess"

local harfbuzz_features = {
  "calt",
  "liga",
  "dlig",
  "ss01",
  "ss02",
  "ss03",
  "ss04",
  "ss05",
  "ss06",
  "ss07",
  "ss08",
}
config.font_size = 17
config.font = wezterm.font({
  family = "Operator Mono",
  weight = "Book",
  harfbuzz_features = harfbuzz_features,
})

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
  config.color_scheme = "Princess"
else
  -- config.color_scheme = "Princess Light"
  config.color_scheme = "Princess"
end

return config
