vim.opt.filetype = 'on'
vim.opt.filetype.indent = 'on'
vim.opt.filetype.plugin = 'on'

require('plugins')

----------------
-- Indentation
--
-- Vim Sleuth handles this nicely for us.

-- vim.opt.smartindent = true  -- Use whatever the file is using
-- vim.opt.expandtab = true    -- Pressing <Tab> inserts spaces instead of tabs.
-- vim.opt.shiftround = true   -- Pressing <Tab> will round to the nearest tab.
-- vim.opt.shiftwidth = 2      -- Pressing <Tab> inserts 2 spaces.
-- vim.opt.softtabstop = 2     -- How many spaces to insert when pressing <Tab>
-- vim.opt.tabstop = 2         -- Visual appearance of tabs

----------------
-- Folding
--
-- I prefer to not use folds.

vim.opt.foldenable = false
vim.opt.foldlevel = 20
vim.opt.foldlevelstart = 20
vim.opt.foldmethod = 'syntax' -- If folding is used, use the syntax to do it.
vim.opt.foldminlines = 0
vim.opt.foldnestmax = 3

----------------
-- Leader keys

vim.g.mapleader = ','
vim.g.maplocalleader = '\\'

----------------
-- Diff formatting
--

vim.opt.diffopt = {
  'filler',
  'iwhite',
  'vertical',
  'closeoff',
  'algorithm:histogram'
}

----------------
-- Theme
--
-- And other visual preferences and interactive behaviors.

vim.keymap.set('n', '<Leader>c', ':set list!<cr>')
vim.opt.listchars = {
  tab = '› ',
  trail = '•',
  nbsp = '␣',
  space = '·',
  extends = '…',
  precedes = '…',
  eol='↵',
}
vim.opt.fillchars = {
  vert = '┃',
  diff = '╱',
  fold = '⎯',
  foldclose = '',
  foldopen = '',
}
vim.opt.showbreak = '↪ '        -- Displays when a line wraps.

vim.opt.shortmess:append({
  a = true, -- Uses filmnrwx (see :h shortmess)
  I = true, -- Hide the intro messages
  c = true, -- Don't show completion messages, e.g.: "-- XXX completion (YYY)"
})

vim.opt.wrap = false            -- Don't wrap by default

vim.opt.ignorecase = true

-- Tab and status lines
vim.opt.showtabline = 2         -- Always display the tab bar.
vim.opt.showmode = false        -- Hide current mode, it is in our status line

-- Split behaviour
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Gutter
vim.opt.number = true           -- Display line numbers
vim.opt.relativenumber = true   -- Set line numbers to realtive numbers
vim.opt.signcolumn = "yes"      -- Always show the full gutter, even if empty.

-- Cursor and mouse
vim.opt.scrolloff = 10          -- Scroll when within 10 rows of top/bottom
vim.opt.sidescrolloff = 10      -- Scroll when within 10 columns of left/right
vim.opt.updatetime = 250        -- Shorten the "idle" time for autocmds
vim.opt.cursorline = true       -- Highlight the current cursor linea.
vim.opt.guicursor = {           -- Styles for the cursor indicator
  a = 'block',
  n = 'Cursor',
}
vim.opt.mouse = 'a'
-- vim.opt.mousescroll = {
--   vert = 1,
--   hor = 1,
-- }

-- set t_Co=256
-- set t_8f=[38;2;%lu;%lu;%lum
-- set t_8b=[48;2;%lu;%lu;%lum

vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.cmd.colorscheme('princess_theme')
