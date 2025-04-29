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
  "tpope/vim-commentary", -- gcc to comment line/paragraph
  "tpope/vim-surround", -- Change surrounds, quotes etc
  "tpope/vim-fugitive", -- Git wrapper, :Gstatus etc

  "Xvezda/vim-readonly", -- Lock a bunch of files like node_modules

  "fladson/vim-kitty", -- Kitty config syntax

  -- "justinmk/vim-sneak", -- Minimal EasyMotion s
  {
    "ggandor/leap.nvim",
    lazy = false,
    config = function()
      -- require("leap").create_default_mappings()
      vim.keymap.set("n", "s", "<Plug>(leap)")
      vim.keymap.set("n", "S", "<Plug>(leap-from-window)")

      require("leap").opts.highlight_unlabeled_phase_one_targets = true
    end,
  },

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
          virtualtext = "⏹",
        },
      })
    end,
  },

  ------------------
  -- Trouble
  --
  -- 🚦 A pretty diagnostics, references, telescope results, quickfix and
  -- location list to help you solve all the trouble your code is causing.
  --
  -- https://github.com/folke/trouble.nvim
  ------------------
  {
    "folke/trouble.nvim",
    -- enabled = false, -- View gone a little weird
    dependencies = "nvim-tree/nvim-web-devicons",
    cmd = "Trouble",
    config = true,
  },

  {
    "folke/lazydev.nvim",
    ft = "lua",
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
  -- Wilder
  --
  -- A more adventurous wildmenu
  --
  -- https://github.com/gelguy/wilder.nvim
  ------------------
  {
    "gelguy/wilder.nvim",
    -- enabled = false, -- Doesn't play well with noice
    config = function()
      local wilder = require("wilder")
      wilder.setup({
        modes = { ":", "/" },
        next_key = "<C-k>",
        previous_key = "<C-j>",
        accept_key = "<Tab>",
      })

      wilder.set_option(
        "pipeline",
        wilder.branch(wilder.cmdline_pipeline({
          fuzzy = 1,
        }))
      )

      wilder.set_option(
        "renderer",
        wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
          highlights = {
            border = "Normal",
          },
          border = "rounded",
          pumblend = 20,
          -- highlighter applies highlighting to the candidates
          highlighter = wilder.basic_highlighter(),
          reverse = 1,
          left = { " ", wilder.popupmenu_devicons() },
          right = { " ", wilder.popupmenu_scrollbar() },
        }))
      )
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
    init = function()
      local group = vim.api.nvim_create_augroup("PersistedHooks", {})

      local function get_cwd_as_name()
        local dir = vim.fn.getcwd(0)
        return dir:gsub("[^A-Za-z0-9]", "_")
      end

      -- vim.api.nvim_create_autocmd({ "User" }, {
      --   pattern = "PersistedSavePre",
      --   group = group,
      --   callback = function(a)
      --     vim.notify("Save session" .. a.data)

      --     local overseer = require("overseer")
      --     overseer.save_task_bundle(
      --       get_cwd_as_name(),
      --       nil,
      --       { on_conflict = "overwrite" }
      --     )
      --   end,
      -- })

      -- vim.api.nvim_create_autocmd({ "User" }, {
      --   pattern = "PersistedLoadPost",
      --   group = group,
      --   callback = function(session)
      --     -- if session == nil or session.name == nil then
      --     --   return
      --     -- end

      --     vim.notify("Loaded session " .. vim.inspect(session))
      --   end,
      -- })
    end,
  },
}
