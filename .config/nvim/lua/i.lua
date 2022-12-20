vim.opt.filetype="on"
vim.opt.filetype.indent="on"
vim.opt.filetype.plugin="on"

require("plugins")

-- Indentation
-- I prefer spaces over tabs.
vim.opt.expandtab=true -- Pressing <Tab> inserts spaces instead of tabs.
vim.opt.tabstop=2 -- Default is 8, I prefer 2.
vim.opt.softtabstop=2
vim.opt.shiftwidth=2
vim.opt.shiftround=true -- Pressing <Tab> will round to the nearest tab.


-- Folding
-- I prefer to not use folds.
vim.opt.foldenable=false
vim.opt.foldlevel=20
vim.opt.foldlevelstart=20
vim.opt.foldmethod="syntax" -- If folding is used, use the syntax to do it.
vim.opt.foldminlines=0
vim.opt.foldnestmax=3


-- Leader keys
vim.g.mapleader=","
vim.g.maplocalleader="\\"


-- Theme
vim.opt.termguicolors=true
vim.opt.background="dark"
vim.cmd("colorscheme princess_theme")
