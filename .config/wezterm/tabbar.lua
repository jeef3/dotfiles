local wz = require("wezterm")

local c = require("colors")

wz.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local title = tab.active_pane.title

  if tab.tab_title and #tab.tab_title > 0 then
    title = tab.tab_title
  end

  if tab.is_active then
    return {
      { Foreground = { Color = c.pink } },
      { Background = { Color = c.silver_700 } },
      { Text = "▎" },
      { Foreground = { Color = c.orange } },
      { Text = (tab.tab_index + 1) .. " " },
      { Attribute = { Intensity = "Bold" } },
      { Foreground = { Color = c.silver_100 } },
      { Background = { Color = c.silver_500 } },
      { Text = " " .. title .. " " },
      { Background = { Color = c.silver_900 } },
      { Text = " " },
    }
  else
    return {
      { Foreground = { Color = c.silver_400 } },
      { Background = { Color = c.silver_800 } },
      { Text = "▎" },
      { Foreground = { Color = c.silver_400 } },
      { Text = (tab.tab_index + 1) .. " " },
      { Background = { Color = c.silver_700 } },
      { Text = " " .. title .. " " },
      { Background = { Color = c.silver_900 } },
      { Text = " " },
    }
  end
end)
