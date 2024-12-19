local function basename(str)
  if str then
    return string.gsub(str, "(.*[/\\])(.*)", "%2")
  else
    return ""
  end
end

return function(window)
  local pane = window:active_pane()
  local name = pane:get_foreground_process_name()

  return "  " .. basename(name) .. " "
end
