----------------
-- Diff View
--
-- https://github.com/sindrets/diffview.nvim
----------------

require('diffview').setup({
  enhanced_diff_hl = true,
  signs = {
    fold_closed = '',
    fold_open = '',
    done = '✓',
  },
  hooks = {
    view_enter = function(view)
      vim.cmd [[:Gitsigns toggle_numhl true]]
    end,
    view_leave = function(view)
      vim.cmd [[:Gitsigns toggle_numhl false]]
    end,
  },
})
