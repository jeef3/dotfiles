----------------
-- Git Signs
--
-- https://github.com/lewis6991/gitsigns.nvim
----------------

return {
  "lewis6991/gitsigns.nvim",
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "▎" },
    },

    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map("n", "]c", function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return "<Ignore>"
      end, { expr = true })

      map("n", "[c", function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end, { expr = true })

      -- Actions
      map({ "n", "v" }, "<Leader>hs", ":Gitsigns stage_hunk<CR>")
      map({ "n", "v" }, "<Leader>hr", ":Gitsigns reset_hunk<CR>")
      map("n", "<Leader>hS", gs.stage_buffer)
      map("n", "<Leader>hu", gs.undo_stage_hunk)
      map("n", "<Leader>hR", gs.reset_buffer)
      map("n", "<Leader>hp", gs.preview_hunk)
      map("n", "<Leader>hb", function()
        gs.blame_line({ full = true })
      end)
      map("n", "<Leader>tb", gs.toggle_current_line_blame)
      map("n", "<Leader>hd", gs.diffthis)
      map("n", "<Leader>hD", function()
        gs.diffthis("~")
      end)
      map("n", "<Leader>td", gs.toggle_deleted)

      -- Text object
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
    end,
  },
}
