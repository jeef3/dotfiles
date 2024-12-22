local wezterm = require("wezterm")

return function(window)
  local cwd
  local pane = window:active_pane()

  if not pane then
    return " "
  end

  local cwd_uri = pane:get_current_working_dir()

  if not cwd_uri then
    return " "
  end

  cwd = cwd_uri.file_path:match("([^/]+)/?$")

  if #cwd > 10 then
    cwd = cwd:sub(1, 10 - 1) .. "…"
  end

  return "  " .. cwd .. " "
end
