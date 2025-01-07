local c = require("colors")

local ansi = {
  dim = {
    c.silver_900, -- Black
    c.pink_600, -- Dark Red
    c.green_600, -- Dark Green
    c.orange_600, -- Dark Yellow
    c.blue_600, -- Dark Blue
    c.purple_600, -- Dark Purple
    c.turquoise_600, -- Dark Cyan
    c.silver_300, -- Light Grey
  },
  bright = {
    c.silver_500, -- Dark Grey
    c.pink_500, -- Red
    c.green_500, -- Green
    c.orange_500, -- Yellow
    c.blue_500, -- Blue
    c.purple_500, -- Purple
    c.turquoise_500, -- Cyan
    c.silver_100, -- White
  },
}

return {
  light = {
    ansi = ansi.dim,
    brights = ansi.bright,

    foreground = c.silver_900,
    background = c.silver_100,
    split = c.silver_500,

    cursor_bg = c.silver_900,
    cursor_border = c.silver_500,
  },
  dark = {
    ansi = ansi.dim,
    brights = ansi.bright,

    foreground = c.silver_100,
    background = c.silver_900,
    split = c.silver_500,

    tab_bar = {
      background = c.silver_900,

      active_tab = {
        fg_color = c.silver_100,
        bg_color = c.silver_500,
      },

      inactive_tab = {
        fg_color = c.silver_400,
        bg_color = c.silver_900,
      },
      inactive_tab_hover = {
        fg_color = c.silver_300,
        bg_color = c.silver_800,
      },
    },

    cursor_bg = c.silver_100,
    cursor_border = c.silver_500,
  },
}
