local wz = require("wezterm")
local appearance = require("appearance")
local act = wz.action

local c = require("colors")

local config = wz.config_builder()
config.keys = {}
config.key_tables = { tmux = {} }

require("resurrect").setup(config)
require("tabbar")

-- config.leader =
--   { key = "b", mods = "CTRL", timeout_milliseconds = math.maxinteger }

config.status_update_interval = 1000

table.insert(config.keys, {
  key = "b",
  mods = "CTRL",
  action = act.ActivateKeyTable({
    name = "tmux",
    one_shot = true,
  }),
  -- action = wz.action_callback(function()
  --   wz.log_info("Leader active")
  --   act.ActivateKeyTable({
  --     name = "tmux",
  --     timeout_milliseconds = math.maxinteger,
  --   })
  --   act.EmitEvent("tmux_plugin.show")
  -- end),
  -- action = act.EmitEvent("tmux_plugin.show"),
})

wz.on("tmux_plugin.show", function()
  wz.log_info("I heard ya")

  act.ActivateKeyTable({
    name = "tmux",
    timeout_milliseconds = math.maxinteger,
  })
end)

local function lm(key, action)
  table.insert(config.key_tables.tmux, { key = key, action = action })
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
-- config.font = wz.font("OperatorMonoLig Nerd Font")
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
config.font_size = 17

config.colors = {
  foreground = c.silver_200,
  background = c.silver_900,

  tab_bar = {
    background = c.silver_900,

    active_tab = {
      fg_color = c.silver_100,
      bg_color = c.silver_500,
    },

    inactive_tab = {
      fg_color = c.silver_400,
      bg_color = c.silver_900,
    },
    inactive_tab_hover = {
      fg_color = c.silver_300,
      bg_color = c.silver_800,
    },
  },

  ansi = {
    c.silver_900,
    c.pink,
    c.green,
    "olive",
    c.blue,
    c.purple,
    c.turquoise,
    c.silver_500,
  },
  brights = {
    c.silver_500,
    "red",
    "lime",
    c.orange,
    c.blue,
    c.pink_600,
    "aqua",
    c.silver_100,
  },
}

config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.window_frame = {
  border_left_width = 0,
  border_right_width = 0,
  border_bottom_height = 0,
  border_top_height = 0,

  active_titlebar_bg = c.silver_900,

  font = wz.font({ family = "Operator Mono" }),
  font_size = 17,
}

config.window_padding = {
  top = 0,
  right = 0,
  bottom = 0,
  left = 0,
}

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

-- if appearance.is_dark() then
--   config.color_scheme = "Mocha (dark) (terminal.sexy)"
-- else
--   config.color_scheme = "Mocha (light) (terminal.sexy)"
-- end

return config
