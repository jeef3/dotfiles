lua << EOF
--require 'illuminate'
--require("scrollbar").setup()

-- vim.cmd [[autocmd ColorScheme * highlight NormalFloat guibg=#1f2335]]
-- vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]


-- vim.cmd("command! NeoTestNearest lua require('neotest').run.run()")
-- vim.cmd("command! NeoTestFile lua require('neotest').run.run(vim.fn.expand('%'))")

-- require("coverage").setup()

require("i")
EOF
