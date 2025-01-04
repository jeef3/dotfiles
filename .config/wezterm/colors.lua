local wezterm = require("wezterm")
local p = wezterm.color.parse

local silver_100 = p("#f8f8ff")
local silver_200 = p("#dfdfe0")
local silver_300 = p("#b3b3d4")
local silver_400 = p("#a09bb3")
local silver_500 = p("#686889")
local silver_600 = p("#4b4b50")
local silver_700 = p("#393b44")
local silver_800 = p("#2C2C3E")
local silver_900 = p("#1d1d26")

local pink_500 = p("#ff3399")
local pink_600 = pink_500:darken(0.25)

local blue_500 = p("#00bfff")
local blue_600 = blue_500:darken(0.25)

local turquoise_500 = p("#00ced1")
local turquoise_600 = turquoise_500:darken(0.25)

local green_500 = p("#00d364")
local green_600 = green_500:darken(0.25)

local purple_500 = p("#cc66ff")
local purple_600 = purple_500:darken(0.25)

local orange_500 = p("#ffcc66")
local orange_600 = orange_500:darken(0.25)

return {
  silver_100 = silver_100,
  silver_200 = silver_200,
  silver_300 = silver_300,
  silver_400 = silver_400,
  silver_500 = silver_500,
  silver_600 = silver_600,
  silver_700 = silver_700,
  silver_800 = silver_800,
  silver_900 = silver_900,

  pink_500 = pink_500,
  pink_600 = pink_600,

  blue_500 = blue_500,
  blue_600 = blue_600,

  turquoise_500 = turquoise_500,
  turquoise_600 = turquoise_600,

  green_500 = green_500,
  green_600 = green_600,

  purple_500 = purple_500,
  purple_600 = purple_600,

  orange_500 = orange_500,
  orange_600 = orange_600,
}
