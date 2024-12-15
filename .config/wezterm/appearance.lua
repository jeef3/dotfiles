local wz = require("wezterm")

local M = {}

function M.is_dark()
  if wz.gui then
    return wz.gui.get_appearance():find("Dark")
  end

  return true
end

return M
