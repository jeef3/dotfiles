local wezterm = require("wezterm")
local act = wezterm.action
local resurrect =
  wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")

local M = {}

function M.setup(config)
  resurrect.state_manager.periodic_save({
    interval_seconds = 60 * 5,
  })

  wezterm.on("gui-startup", resurrect.state_manager.resurrect_on_gui_startup)

  wezterm.on("smart_workspace_switcher.workspace_switcher.selected", function()
    resurrect.save_state(resurrect.workspace_state.get_workspace_state())
  end)

  table.insert(config.key_tables.tmux_mode, {
    key = "s",
    mods = "CTRL",
    action = act.Multiple({
      wezterm.action_callback(function()
        resurrect.state_manager.write_current_state()
      end),
      act.EmitEvent("tmux_mode.inactive"),
    }),
  })

  table.insert(config.key_tables.tmux_mode, {
    key = "d",
    mods = "CTRL",
    action = act.Multiple({
      wezterm.action_callback(function(win, pane)
        resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id)
          resurrect.state_manager.delete_state(id)
        end, {
          title = "Delete State",
          description = "Select State to Delete and press Enter = accept, Esc = cancel, / = filter",
          fuzzy_description = "Search State to Delete: ",
          is_fuzzy = true,
        })
      end),
      act.EmitEvent("tmux_mode.inactive"),
    }),
  })

  table.insert(config.key_tables.tmux_mode, {
    key = "r",
    mods = "CTRL",
    action = act.Multiple({
      wezterm.action_callback(function(win, pane)
        resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id)
          local type = string.match(id, "^([^/]+)") -- match before '/'
          id = string.match(id, "([^/]+)$") -- match after '/'
          id = string.match(id, "(.+)%..+$") -- remove file extention
          local opts = {
            relative = true,
            restore_text = true,
            on_pane_restore = resurrect.tab_state.default_on_pane_restore,
          }
          if type == "workspace" then
            local state = resurrect.state_manager.load_state(id, "workspace")
            resurrect.workspace_state.restore_workspace(state, opts)
          elseif type == "window" then
            local state = resurrect.state_manager.load_state(id, "window")
            resurrect.window_state.restore_window(pane:window(), state, opts)
          elseif type == "tab" then
            local state = resurrect.state_manager.load_state(id, "tab")
            resurrect.tab_state.restore_tab(pane:tab(), state, opts)
          end
        end)
      end),
      act.EmitEvent("tmux_mode.inactive"),
    }),
  })
end

return M
