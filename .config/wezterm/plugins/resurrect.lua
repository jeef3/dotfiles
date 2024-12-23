local wezterm = require("wezterm")
local resurrect =
  wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")

local M = {}

function M.setup(config)
  -- resurrect.set_encryption({
  --   enable = true,
  --   method = "gpg",
  --   public_key = "~/.ssh/id_ed25519.pub",
  -- })

  resurrect.periodic_save({
    interval_seconds = 60 * 5,
  })

  -- loads the state whenever I create a new workspace
  wezterm.on(
    "smart_workspace_switcher.workspace_switcher.created",
    function(window, _, label)
      local workspace_state = resurrect.workspace_state

      workspace_state.restore_workspace(
        resurrect.load_state(label, "workspace"),
        {
          window = window,
          relative = true,
          restore_text = true,
          on_pane_restore = resurrect.tab_state.default_on_pane_restore,
        }
      )
    end
  )

  wezterm.on("smart_workspace_switcher.workspace_switcher.selected", function()
    resurrect.save_state(resurrect.workspace_state.get_workspace_state())
  end)

  table.insert(config.key_tables.tmux_mode, {
    key = "d",
    mods = "CTRL",
    action = wezterm.action_callback(function(win, pane)
      resurrect.fuzzy_load(win, pane, function(id)
        resurrect.delete_state(id)
      end, {
        title = "Delete State",
        description = "Select State to Delete and press Enter = accept, Esc = cancel, / = filter",
        fuzzy_description = "Search State to Delete: ",
        is_fuzzy = true,
      })
    end),
  })

  table.insert(config.key_tables.tmux_mode, {
    key = "r",
    mods = "CTRL",
    action = wezterm.action_callback(function(win, pane)
      resurrect.fuzzy_load(win, pane, function(id, _label)
        local type = string.match(id, "^([^/]+)") -- match before '/'
        id = string.match(id, "([^/]+)$") -- match after '/'
        id = string.match(id, "(.+)%..+$") -- remove file extention
        local opts = {
          relative = true,
          restore_text = true,
          on_pane_restore = resurrect.tab_state.default_on_pane_restore,
          tab = win:active_tab(),
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
