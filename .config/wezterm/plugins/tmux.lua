local wezterm = require("wezterm")
local act = wezterm.action

local M = {}

local defaults = {
  key = "b",
  mods = "CTRL",
}

local function build_mapper(tbl)
  return function(key, action)
    table.insert(tbl, {
      key = key,
      action = act.Multiple({
        action,
        act.EmitEvent("tmux_mode.inactive"),
      }),
    })
  end
end

function M.setup(config, opts)
  config.key_tables = { tmux_mode = {} }

  opts = opts or defaults
  opts.key = opts.key or defaults.key
  opts.mods = opts.mods or defaults.mods

  if config.keys == nil then
    config.keys = {}
  end

  if config.key_tables == nil then
    config.key_tables = {}
  end

  config.key_tables.tmux_mode = {}

  table.insert(config.keys, {
    key = opts.key,
    mods = opts.mods,
    action = act.Multiple({
      act.ActivateKeyTable({
        name = "tmux_mode",
        one_shot = true,
      }),
      act.EmitEvent("tmux_mode.active"),
    }),
  })

  local map = build_mapper(config.key_tables.tmux_mode)

  map("Escape", act.EmitEvent("tmux_mode.inactive"))

  map(":", act.ActivateCommandPalette)

  -- Pane Splits
  map('"', act.SplitHorizontal({ domain = "CurrentPaneDomain" }))
  map("%", act.SplitVertical({ domain = "CurrentPaneDomain" }))
  map(" ", act.RotatePanes("Clockwise"))

  -- Pane Navigation
  map("h", act.ActivatePaneDirection("Left"))
  map("j", act.ActivatePaneDirection("Down"))
  map("k", act.ActivatePaneDirection("Up"))
  map("l", act.ActivatePaneDirection("Right"))

  -- Pane Actions
  map("z", act.TogglePaneZoomState)
  map("x", act.CloseCurrentPane({ confirm = true }))
  map("s", act.PaneSelect)

  -- Tab Navigation
  map("n", act.ActivateTabRelative(1))
  map("p", act.ActivateTabRelative(-1))
  map("c", act.SpawnTab("CurrentPaneDomain"))

  for i = 1, 9 do
    map(tostring(i), act.ActivateTab(i - 1))
  end

  -- Tab Actions
  map(
    ",",
    act.PromptInputLine({
      description = "Enter new name for tab",
      action = wezterm.action_callback(function(window, _, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    })
  )

  map(
    "$",
    act.PromptInputLine({
      description = "Enter new name for session",
      action = wezterm.action_callback(function(window, _, line)
        if line then
          window:active_workspace():set_title(line)
        end
      end),
    })
  )
end

return M
