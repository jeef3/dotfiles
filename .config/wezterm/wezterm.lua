local wz = require("wezterm")
local act = wz.action
-- local resurrect =
--   wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
-- local bar = wz.plugin.require("https://github.com/adriankarlen/bar.wezterm")
local c = require("colors")

require("tabbar")

local config = wz.config_builder()

config.keys = {}
config.leader = { key = "b", mods = "CTRL", timeout = 5000 }

local function lm(key, action)
  table.insert(config.keys, { key = key, mods = "LEADER", action = action })
end

lm(":", act.ActivateCommandPalette)

-- Pane Splits
lm('"', act.SplitHorizontal({ domain = "CurrentPaneDomain" }))
lm("%", act.SplitVertical({ domain = "CurrentPaneDomain" }))
lm(" ", act.RotatePanes("Clockwise"))

-- Pane Navigation
lm("h", act.ActivatePaneDirection("Left"))
lm("j", act.ActivatePaneDirection("Down"))
lm("k", act.ActivatePaneDirection("Up"))
lm("l", act.ActivatePaneDirection("Right"))

-- Pane Actions
lm("z", act.TogglePaneZoomState)
lm("x", act.CloseCurrentPane({ confirm = true }))

-- Tab Navigation
lm("n", act.ActivateTabRelative(1))
lm("p", act.ActivateTabRelative(-1))
-- for i = 1, 9 do
--   lm(toString(i), act.ActivateTab(i - 1))
-- end

-- Tab Actions
lm(
  ",",
  act.PromptInputLine({
    description = "Enter new name for tab",
    action = wz.action_callback(function(window, pane, line)
      if line then
        window:active_tab():set_title(line)
      end
    end),
  })
)

lm(
  "$",
  act.PromptInputLine({
    description = "Enter new name for session",
    action = wz.action_callback(function(window, pane, line)
      window:perform_action(
        act.SwitchToWorkspace({
          name = line,
        }),
        pane
      )
    end),
  })
)
config.enable_scroll_bar = false

config.font = wz.font("Operator Mono")
-- config.font_antialias = "Subpixel"
-- config.font_hinting = "Full"
-- config.font = wezterm.font("OperatorMonoLig Nerd Font")
config.font_rules = {
  {
    intensity = "Bold",
    italic = false,
    font = wz.font("OperatorMonoSSmLig Nerd Font"),
  },
  {
    intensity = "Bold",
    italic = true,
    font = wz.font("OperatorMonoSSmLig Nerd Font", { italic = true }),
  },
}
config.font_size = 19

config.colors = {
  foreground = c.silver_200,
  background = c.silver_900,

  tab_bar = {
    background = c.silver_900,
  },
}

config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wz.nerdfonts.pl_right_hard_divider

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wz.nerdfonts.pl_left_hard_divider

config.window_decorations = "TITLE|RESIZE"
-- config.window_background_opacity = 0.65
config.macos_window_background_blur = 50

config.window_frame = {
  border_left_width = 1,
  border_right_width = 1,
  border_bottom_height = 1,
  border_top_height = 0,
  -- border_left_color = "silver",
  -- border_right_color = "silver",
  -- border_bottom_color = "silver",
  -- border_top_color = "silver",
}

config.window_padding = {
  top = 0,
  right = 0,
  bottom = 0,
  left = 0,
}

-- wezterm.on("update-left-status", function(window, pane)
--   local date = wezterm.strftime("󰸗 %a %d %b %H:%M")
--   -- Make it italic and underlined
--   window:set_left_status(wezterm.format({
--     { Foreground = { Color = green } },
--     { Text = "󱊣" },
--     { Foreground = { Color = orange } },
--     { Text = " " .. date },
--   }))
-- end)

-- wezterm.on("update-right-status", function(window, pane)
--   local date = wezterm.strftime("󰸗 %a %d %b %H:%M")
--   -- Make it italic and underlined
--   window:set_right_status(wezterm.format({
--     { Foreground = { Color = green } },
--     { Text = "󱊣" },
--     { Foreground = { Color = orange } },
--     { Text = " " .. date .. " " },
--   }))
-- end)

-- wezterm.on("format-window-title", function()
--   local title = "[" .. wezterm.mux.get_active_workspace() .. "]"
--   title = title .. " " .. wezterm.mux.get_domain():name()
--   title = title .. " - $W"
--   -- some logic here
--   return title
-- end)

-- bar.apply_to_config(config, {
--   position = "top",
--   modules = {
--     workspace = { enabled = true },
--     pane = { enabled = false },
--     leader = { enabled = true },
--     hostname = { enabled = false },
--     username = { enabled = false },
--     clock = { enabled = false },
--   },
-- })

return config
