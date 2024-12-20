local wezterm = require("wezterm")
local workspace_switcher = wezterm.plugin.require(
  "https://github.com/MLFlexer/smart_workspace_switcher.wezterm"
)

local M = {}

function M.setup(config)
  table.insert(config.key_tables.tmux_mode, {
    key = "w",
    action = workspace_switcher.switch_workspace(),
  })

  workspace_switcher.apply_to_config(config)
end

return M
