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

  wezterm.on("augment-command-palette", function()
    return {
      {
        brief = "Window | Workspace: Switch Workspace",
        icon = "md_briefcase_arrow_up_down",
        action = workspace_switcher.switch_workspace(),
      },
    }
  end)

  workspace_switcher.apply_to_config(config)
end

return M
