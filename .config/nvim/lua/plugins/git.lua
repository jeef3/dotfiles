return {
  ----------------
  -- Git Signs
  --
  -- Git integration for buffers
  --
  -- https://github.com/lewis6991/gitsigns.nvim
  ----------------
  {
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
        map(
          { "n", "v" },
          "<Leader>hs",
          ":Gitsigns stage_hunk<CR>",
          { desc = "Git stage hunk" }
        )
        map(
          { "n", "v" },
          "<Leader>hr",
          ":Gitsigns reset_hunk<CR>",
          { desc = "Git reset hunk" }
        )
        map(
          "n",
          "<Leader>hu",
          gs.undo_stage_hunk,
          { desc = "Git unstage hunk" }
        )
        map(
          "n",
          "<Leader>hp",
          gs.preview_hunk,
          { desc = "Git preview changes " }
        )
        map("n", "<Leader>hb", function()
          gs.blame_line({ full = true })
        end, { desc = "Git blame" })
        map(
          "n",
          "<Leader>tb",
          gs.toggle_current_line_blame,
          { desc = "Git current line blame" }
        )
        map("n", "<Leader>hd", gs.diffthis, { desc = "Git show diff for file" })
        map(
          "n",
          "<Leader>td",
          gs.toggle_deleted,
          { desc = "Git toggle show deleted" }
        )

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
      end,
    },
  },

  ----------------
  -- Diff View
  --
  -- Single tabpage interface for easily cycling through diffs for all modified
  -- files for any git rev.
  --
  -- https://github.com/sindrets/diffview.nvim
  ----------------
  {
    "sindrets/diffview.nvim",
    opts = {
      enhanced_diff_hl = true,
      signs = {
        fold_closed = "",
        fold_open = "",
        done = "✓",
      },
      hooks = {
        view_enter = function()
          vim.cmd([[:Gitsigns toggle_numhl true]])
        end,
        view_leave = function()
          vim.cmd([[:Gitsigns toggle_numhl false]])
        end,
      },
    },
  },

  ----------------
  -- Lazygit
  --
  -- Plugin for calling lazygit from within neovim.
  --
  -- https://github.com/kdheepak/lazygit.nvim
  ----------------
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    config = function()
      vim.g.lazygit_floating_window_winblend = 10
      vim.g.lazygit_floating_window_use_plenary = 0

      vim.keymap.set("n", "<leader>lg", ":LazyGit<CR>", {
        desc = "Open LazyGit",
      })
    end,
  },

  ----------------
  -- Flog
  --
  -- A fast, beautiful, and powerful git branch viewer for vim.
  --
  -- https://github.com/rbong/vim-flog
  ----------------
  {
    "rbong/vim-flog",
    lazy = true,
    cmd = { "Flog", "Flogsplit", "Floggit" },
    dependencies = {
      "tpope/vim-fugitive",
    },
  },
}
