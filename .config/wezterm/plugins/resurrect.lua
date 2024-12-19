local wz = require("wezterm")
local resurrect =
  wz.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")

local M = {}

function M.setup(config)
  table.insert(config.keys, {
    key = "s",
    mods = "LEADER|CTRL",
    action = wz.action_callback(function()
      resurrect.save_state(resurrect.workspace_state.get_workspace_state())
    end),
  })

  table.insert(config.key_tables.tmux_mode, {
    key = "r",
    mods = "CTRL",
    action = wz.action_callback(function(win, pane)
      resurrect.fuzzy_load(win, pane, function(id, label)
        local type = string.match(id, "^([^/]+)") -- match before '/'
        id = string.match(id, "([^/]+)$") -- match after '/'
        id = string.match(id, "(.+)%..+$") -- remove file extention
        local opts = {
          relative = true,
          restore_text = true,
          on_pane_restore = resurrect.tab_state.default_on_pane_restore,
        }
        if type == "workspace" then
          local state = resurrect.load_state(id, "workspace")
          resurrect.workspace_state.restore_workspace(state, opts)
        elseif type == "window" then
          local state = resurrect.load_state(id, "window")
          resurrect.window_state.restore_window(pane:window(), state, opts)
        elseif type == "tab" then
          local state = resurrect.load_state(id, "tab")
          resurrect.tab_state.restore_tab(pane:tab(), state, opts)
        end
      end)
    end),
  })
end

return M
