----------------
-- Leader keys
--
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

----------------
-- Lazy
--
-- Plug in management
vim.opt.termguicolors = true
vim.opt.background = "dark"

require("config.lazy")
require("lazy").setup("plugins")

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

----------------
-- Other settings
--
vim.opt.cmdheight = 1
vim.opt.omnifunc = "syntaxcomplete#Complete"

vim.opt.undofile = true
vim.opt.writebackup = false
vim.opt.swapfile = false

vim.o.sessionoptions =
  "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

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
-- vim.keymap.set("n", "<Leader>c", ":set list!<cr>")

-- Close Quickfix window
vim.keymap.set("n", "<leader>qq", ":cclose<CR>")

-- Useful quick formatting
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

vim.opt.linebreak = true
vim.opt.showbreak = "↪ " -- Displays when a line wraps.

-- Highlight yanked text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 700 })
  end,
})

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
vim.opt.showtabline = 1 -- Only show tab bar if there are 2 or more tabs.
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
vim.opt.mouse = "a"
vim.opt.mousescroll = "ver:1,hor:1"

-- Clipboard
vim.opt.clipboard = "unnamed"

-- Cursor
vim.opt.guicursor = {
  "a:block",
  "n:Cursor",
  "i-ci-sm:Cursor-hor10-blinkon100",

  "v-ve:VisualCursor",
  "r-cr:ReplaceCursor-hor10",
  "c:CommandCursor-hor10",

  "o:hor50-Cursor",
}

vim.g.markdown_fenced_languages = {
  "ts=typescript",
}

-- Mappings
local wk = require("which-key")
wk.add({
  { "<leader>g", group = " Git Tools…" },
  { "<leader>gb", "<cmd>Flog<CR>", desc = "Open Git branch view" },
  { "<leader>gs", "<cmd>Telescope git_branches<CR>", desc = "Switch branch" },

  { "<leader>h", group = " Git Changes…" },
  { "<leader>hb", ":Gitsigns blame_line<CR>", desc = "Blame" },
  {
    "<leader>hd",
    ":Gitsigns diffthis<CR>",
    desc = "Show diff for whole file",
  },
  {
    "<leader>hp",
    ":Gitsigns preview_hunk<CR>",
    desc = "Preview hunk changes",
  },
  { "<leader>hr", ":Gitsigns reset_hunk<CR>", desc = "Reset hunk changes" },
  { "<leader>hs", ":Gitsigns stage_hunk<CR>", desc = "Stage hunk" },
  {
    "<leader>ht",
    ":Gitsigns toggle_deleted<CR>",
    desc = "Toggle show deleted",
  },
  { "<leader>hu", ":Gitsigns unstage_hunk<CR>", desc = "Unstage hunk" },

  {
    "<leader>o",
    "<cmd>AerialToggle!<CR>",
    desc = "Toggle outline",
  },
  { "<leader>t", group = "󰙨 Test…" },

  -- Copilot keys
  {
    "<leader>cc",
    "<cmd>CopilotChatToggle<cr>",
    desc = "Open Copilot Chat",
  },
  {
    "<leader>cC",
    "<cmd>CopilotChatClear<cr>",
    desc = "Clear Copilot Chat",
  },
  {
    "<leader>cS",
    "<cmd>CopilotChatSend<cr>",
    desc = "Send message to Copilot Chat",
  },
})
