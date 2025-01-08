local wezterm = require("wezterm")

local last_update_time = 0
local last_result = ""

local throttle = 3
local icon = wezterm.nerdfonts.dev_git_branch

return function(window)
  local current_time = os.time()
  if current_time - last_update_time < throttle then
    return last_result
  end

  local pane = window:active_pane()

  if not pane then
    return ""
  end

  local cwd_uri = pane:get_current_working_dir()

  if not cwd_uri then
    return ""
  end

  local success, result = wezterm.run_child_process({
    "git",
    "-C",
    cwd_uri.file_path,
    "rev-parse",
    "--abbrev-ref",
    "HEAD",
  })

  if not result then
    return ""
  end

  local branch = result:gsub("\n", "")

  if branch then
    return "  " .. branch .. " "
  else
    return ""
  end
end
