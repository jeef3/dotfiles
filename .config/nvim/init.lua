----------------
-- Leader keys
--
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

----------------
-- Filetype
--
-- Essential for file type detection and plugins

vim.opt.filetype = "on"
vim.opt.filetype.indent = "on"
vim.opt.filetype.plugin = "on"

require("plugins")

----------------
-- Diff formatting
--

vim.opt.diffopt = {
  "filler", -- Show filler lines
  "iwhite", -- Ignore whitespace changes
  "vertical", -- Start in vertical split mode
  "closeoff", -- Stop the diff when we close
  "algorithm:histogram",
}
--
----------------
-- Other settings
--
vim.opt.omnifunc = "syntaxcomplete#Complete"
vim.opt.completeopt = { "menu", "menuone", "noselect" }

----------------
-- Netrw
--
vim.g.netrw_bufsettings = "noma nomod nun nobl nowrap ro rnu"

----------------
-- Key mappings and custom script
--

-- Easier split switching (Ctrl-j, Ctrl-k, Ctrl-h, Ctrl-l)
vim.keymap.set("n", "<C-j>", "<C-W>j")
vim.keymap.set("n", "<C-k>", "<C-W>k")
vim.keymap.set("n", "<C-h>", "<C-W>h")
vim.keymap.set("n", "<C-l>", "<C-W>l")

-- Toggle display of listchars
vim.keymap.set("n", "<Leader>c", ":set list!<cr>")

-- Close Quickfix window
vim.keymap.set("n", "<leader>qq", ":cclose<CR>")

vim.cmd([[
  com! FormatJSON %!python3 -m json.tool
  com! FormatHTML %!tidy -iq -xml -wrap 0
]])

----------------
-- Theme
--
-- Visual preferences and interactive behaviors.

vim.opt.listchars = {
  tab = "› ",
  trail = "•",
  nbsp = "␣",
  space = "·",
  extends = "…",
  precedes = "…",
  eol = "↵",
}

vim.opt.fillchars = {
  vert = "┃",
  diff = "╱",
  fold = "⎯",
  foldclose = "",
  foldopen = "",
}

vim.opt.showbreak = "↪ " -- Displays when a line wraps.

vim.opt.report = 0 -- Always show number of lines changed
vim.opt.shortmess:append({
  a = true, -- Uses filmnrwx (see :h shortmess)
  I = true, -- Hide the intro messages
  c = true, -- Don't show completion messages, e.g.: "-- XXX completion (YYY)"
})

vim.opt.wrap = false -- Don't wrap by default

vim.opt.ignorecase = true -- When searching, ignore case

-- Backspace behaviour in insert mode. This makes <Backspace|Delete> "work".
vim.opt.backspace = { "indent", "eol", "start" }

-- Folding (prefer no folds)
vim.opt.foldenable = false
vim.opt.foldlevel = 20
vim.opt.foldlevelstart = 20
vim.opt.foldmethod = "syntax" -- If folding is used, let the syntax to do it.
vim.opt.foldminlines = 0
vim.opt.foldnestmax = 3

-- Tab and status lines
vim.opt.showtabline = 2 -- Always display the tab bar.
vim.opt.showmode = false -- Hide current mode, it is in our status line

-- Split behaviour
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Gutter
vim.opt.number = true -- Display line numbers
vim.opt.relativenumber = true -- Set line numbers to realtive numbers
vim.opt.signcolumn = "yes" -- Always show the full gutter, even if empty.

-- Cursor and mouse
vim.opt.scrolloff = 10 -- Scroll when within 10 rows of top/bottom
vim.opt.sidescrolloff = 10 -- Scroll when within 10 columns of left/right
vim.opt.updatetime = 250 -- Shorten the "idle" time for autocmds
vim.opt.cursorline = true -- Highlight the current cursor linea.
vim.opt.guicursor = {
  -- Styles for the cursor indicator
  a = "block",
  n = "Cursor",
}
vim.opt.mouse = "a"
vim.opt.mousescroll = "ver:1,hor:1"

-- Clipboard
vim.opt.clipboard = "unnamed"

-- Cursor
vim.opt.guicursor = {
  "a:block",
  "a:blinkon0",
  "n:Cursor",
  "i-ci-sm:InsertCursor-hor10",

  "v-ve:VisualCursor",
  "r-cr:ReplaceCursor-hor10",
  "c:CommandCursor-hor10",

  "o:hor50-Cursor",
}

-- set t_Co=256
-- set t_8f=[38;2;%lu;%lu;%lum
-- set t_8b=[48;2;%lu;%lu;%lum

vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.cmd.colorscheme("princess_theme")

-- Hide all semantic highlights
for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
  vim.api.nvim_set_hl(0, group, {})
end
