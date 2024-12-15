local wz = require("wezterm")
local p = wz.color.parse

local silver_100 = p("#dfdfe0")

local pink = p("#ff3399")

return {
  silver_100 = silver_100,
  silver_200 = "#b3b3d4",
  silver_300 = "#7f8c98",
  silver_400 = "#686889",
  silver_500 = "#414453",
  silver_600 = "#4b4b50",
  silver_700 = "#393b44",
  silver_800 = "#2C2C3E",
  silver_900 = "#1d1d26",

  pink = pink,
  pink_600 = "#ff007a",
  pink_700 = "#96306C",
  pink_900 = "#612E55",

  blue = "#00bfff",

  turquoise = "#00ced1",

  green = "#00d364",

  purple = "#cc66ff",

  orange = "#ffcc66",
}
