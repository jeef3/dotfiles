diffview_toggle = function()
  local lib = require("diffview.lib")
  local view = lib.get_current_view()
  if view then
    -- Current tabpage is a Diffview; close it
    vim.cmd.DiffviewClose()
  else
    -- No open Diffview exists: open a new one
    vim.cmd.DiffviewOpen()
  end
end

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
    cmd = { "Gitsigns" },
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
        end, { expr = true, desc = "Next hunk" })

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Previous hunk" })

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
    keys = {
      {
        "<leader>gd",
        "<cmd>lua diffview_toggle()<CR>",
        desc = "Toggle Git diff view",
      },
    },
    cmd = {
      "DiffviewToggle",
    },
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
