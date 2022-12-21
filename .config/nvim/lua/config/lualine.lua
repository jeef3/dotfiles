----------------
-- Lua Line
--
-- https://github.com/nvim-lualine/lualine.nvim
----------------

require('lualine').setup({
  options = {
    theme = {
      normal = {
        a = 'StatusLineNormalA',
        b = 'StatusLineNormalB',
        c = 'StatusLineNormalC',
      },
      insert = { a = 'StatusLineInsert' },
      replace = { a = 'StatusLineReplace' },
      command = { a = 'StatusLineCommand' },
    },
    component_separators = '╲',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'filename' },
    lualine_c = {  },

    lualine_x = { },
    lualine_y = {
      {
        'diagnostics',
        sources = {'nvim_diagnostic'},
        symbols = { error = ' ', warn = ' ', hint = ' ', info = ' ' },
      },
      {
        'diff',
        colored = true,
        symbols = { added = '+', modified = '~', removed = '-' },
      }
    },
    lualine_z = {'location'},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {'filename'},
    lualine_c = {},

    lualine_x = {
      {
        'diagnostics',
        sources = {'nvim_diagnostic'},
        symbols = { error = ' ', warn = ' ', hint = ' ', info = ' ' },
      },
      {
        'diff',
        colored = true,
        symbols = { added = '+', modified = '~', removed = '-' },
      }
    },
    lualine_y = { 'location' },
    lualine_z = {},
  }
})

