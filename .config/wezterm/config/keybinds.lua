local wezterm = require("wezterm")

local M = {}

function M.setup(config)
  config.disable_default_key_bindings = true
  config.send_composed_key_when_left_alt_is_pressed = true
  config.send_composed_key_when_right_alt_is_pressed = true

  -- Copy
  table.insert(config.keys, {
    mods = "CMD",
    key = "c",
    action = wezterm.action.CopyTo("Clipboard"),
  })

  -- Paste
  table.insert(config.keys, {
    mods = "CMD",
    key = "v",
    action = wezterm.action.PasteFrom("Clipboard"),
  })

  -- Increase/decrease font size
  table.insert(config.keys, {
    mods = "SUPER",
    key = "-",
    action = wezterm.action.DecreaseFontSize,
  })
  table.insert(config.keys, {
    mods = "SUPER",
    key = "+",
    action = wezterm.action.IncreaseFontSize,
  })
  table.insert(config.keys, {
    mods = "SUPER",
    key = "0",
    action = wezterm.action.ResetFontSize,
  })

  -- Show Debug Overlay
  table.insert(config.keys, {
    mods = "SUPER",
    key = "l",
    action = wezterm.action.ShowDebugOverlay,
  })
end

return M
