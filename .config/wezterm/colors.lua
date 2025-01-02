local wz = require("wezterm")
local p = wz.color.parse

local silver_100 = p("#f8f8ff")
local silver_200 = p("#dfdfe0")
local silver_300 = p("#b3b3d4")
local silver_400 = p("#a09bb3")
local silver_500 = p("#686889")
local silver_600 = p("#4b4b50")
local silver_700 = p("#393b44")
local silver_800 = p("#2C2C3E")
local silver_900 = p("#1d1d26")

local pink_400 = p("#FF7086")
local pink_500 = p("#ff3399")
local pink_600 = p("#b12350")

local blue_500 = p("#00bfff")
local blue_600 = p("#8590EC")

local turquoise_500 = p("#00ced1")

local green_400 = p("#BBCE65")
local green_500 = p("#00d364")
local green_600 = p("#057867")

local purple_500 = p("#cc66ff")

local orange_500 = p("#ffcc66")
local orange_600 = p("#ffb070")

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

  pink_400 = pink_400,
  pink_500 = pink_500,
  pink_600 = pink_600,

  blue_500 = blue_500,
  blue_600 = blue_600,

  turquoise_500 = turquoise_500,

  green_400 = green_400,
  green_500 = green_500,
  green_600 = green_600,

  purple_500 = purple_500,

  orange_500 = orange_500,
  orange_600 = orange_600,
}
