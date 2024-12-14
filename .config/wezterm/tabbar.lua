local wz = require("wezterm")

local c = require("./colors")

wz.on("update-right-status", function(window, pane)
  if window:leader_is_active() then
    window:set_left_status(wz.format({
      { Attribute = { Intensity = "Bold" } },
      { Foreground = { Color = c.silver_800 } },
      { Background = { Color = c.orange } },
      { Text = "        " },
      { Foreground = { Color = c.orange } },
      { Background = { Color = c.silver_900 } },
      { Text = " " },
    }))
  else
    window:set_left_status(wz.format({
      { Attribute = { Intensity = "Bold" } },
      { Foreground = { Color = c.silver_400 } },
      { Background = { Color = c.silver_800 } },
      { Text = "   TERM " },
      { Foreground = { Color = c.silver_800 } },
      { Background = { Color = c.silver_900 } },
      { Text = " " },
    }))
  end

  local cwd
  local cwd_uri = pane:get_current_working_dir()
  if cwd_uri then
    local file_path = cwd_uri.file_path
    cwd = file_path:match("([^/]+)/?$")
    if cwd and #cwd > 10 then
      cwd = cwd:sub(1, 10 - 1) .. "…"
    end
  end

  window:set_right_status(wz.format({
    { Foreground = { Color = c.silver_900 } },
    { Background = { Color = c.pink_900 } },
    { Text = "" },
    { Foreground = { Color = c.silver_100 } },
    { Text = "  HI " },
    { Foreground = { Color = c.pink_900 } },
    { Background = { Color = c.pink_700 } },
    { Text = "" },
    { Foreground = { Color = c.silver_100 } },
    { Text = "  HI " },
    { Foreground = { Color = c.pink_700 } },
    { Background = { Color = c.pink } },
    { Text = "" },
    { Foreground = { Color = c.silver_100 } },
    { Text = "   " .. cwd .. " " },
  }))
end)

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
