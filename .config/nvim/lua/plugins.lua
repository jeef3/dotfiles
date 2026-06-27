return {
  ------------------
  -- Tim Pope
  --
  -- Some of his more useful plugins.
  --
  -- https://github.com/tpope
  ------------------
  "tpope/vim-eunuch", -- Better shell cmds, like :Rename
  "tpope/vim-vinegar", -- Netrw enhancements
  "tpope/vim-repeat", -- Get more use out of "."
  "tpope/vim-sleuth", -- Set shiftwidth and expandtab based on current file
  "tpope/vim-surround", -- Change surrounds, quotes etc
  "tpope/vim-fugitive", -- Git wrapper, :Gstatus etc

  "Xvezda/vim-readonly", -- Lock a bunch of files like node_modules

  "MunifTanjim/nui.nvim", -- UI Library

  {
    "kevinhwang91/nvim-hlslens",
    opts = {
      override_lens = function(render, posList, nearest, idx, _)
        local lnum, col = unpack(posList[idx])
        local cnt = #posList
        local text = ("←  %d of %d"):format(idx, cnt)
        local chunks

        if nearest then
          chunks = { { " " }, { text, "HlSearchLensNear" } }
        else
          chunks = { { " " }, { text, "HlSearchLens" } }
        end

        render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
      end,
    },
  },

  -- Colored colors
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        user_default_options = {
          names = false,
          mode = "virtualtext",
          virtualtext = "󱓻",
        },
      })
    end,
  },

  ------------------
  -- Peek
  --
  -- Markdown preview plugin for Neovim
  --
  -- https://github.com/toppair/peek.nvim
  ------------------
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    event = { "VeryLazy" },
    ft = { "md", "markdown" },
    cmd = { "PeekOpen", "PeekClose" },
    config = function()
      require("peek").setup()

      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },

  ------------------
  -- Persisted
  --
  -- 💾 Simple session management for Neovim with git branching, autoloading and
  -- Telescope support
  --
  -- https://github.com/olimorris/persisted.nvim
  ------------------
  {
    "olimorris/persisted.nvim",
    lazy = false,
    opts = {
      autoload = true,
      use_git_branch = true,
    },
  },

  ------------------
  -- pets.nvim
  --
  -- Pets.nvim is a plugin that provides the missing core functionality of
  -- showing little animal friends inside your editor.
  --
  -- https://github.com/giusgad/pets.nvim
  ------------------
  {
    "giusgad/pets.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "giusgad/hologram.nvim" },
    opts = {},
  },

  ------------------
  -- image.nvim
  --
  -- 🖼️ Bringing images to Neovim.
  --
  -- https://github.com/3rd/image.nvim
  ------------------
  {
    "3rd/image.nvim",
    build = false,
    opts = {
      processor = "magick_cli",
    },
  },

  ------------------
  -- worktrees.nvim
  --
  -- Git worktree wrapper for neovim
  --
  -- https://github.com/Juksuu/worktrees.nvim
  ------------------
  {
    "Juksuu/worktrees.nvim",
    keys = {
      {
        "<leader>gws",
        "<cmd>lua Snacks.picker.worktrees()<cr>",
        desc = "Switch",
      },
      {
        "<leader>gwc",
        "<cmd>lua Snacks.picker.worktrees_new()<cr>",
        desc = "Create",
      },
      {
        "<leader>gwr",
        "<cmd>lua Snacks.picker.worktrees_remove()<cr>",
        desc = "Remove",
      },
    },
    opts = {
      worktree_path = "../",
    },
  },
}
