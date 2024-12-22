local c = require("colors")

return {
  foreground = c.silver_100,
  background = c.silver_900,

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

  ansi = {
    c.silver_900,
    c.pink,
    c.green,
    "olive",
    c.blue,
    c.purple,
    c.turquoise,
    c.silver_300,
  },
  brights = {
    c.silver_500,
    c.pink_600,
    "lime",
    c.orange,
    c.blue,
    c.pink_600,
    "aqua",
    c.silver_100,
  },
}
