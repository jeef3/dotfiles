local wezterm = require("wezterm")

local icon = wezterm.nerdfonts.fa_folder_open

return function(window)
  local cwd
  local pane = window:active_pane()

  if not pane then
    return "no pane"
  end

  local cwd_uri = pane:get_current_working_dir()

  if not cwd_uri then
    return "no cwd_uri"
  end

  cwd = cwd_uri.file_path:match("([^/]+)/?$")

  if #cwd > 10 then
    cwd = cwd:sub(1, 10 - 1) .. "…"
  end

  return " " .. icon .. " " .. cwd .. " "
end
