--------------------------------
-- LSP
--
-- LSP specific bits via LSP, with tools installed via Mason. Also indluces code
-- linting/formatting.
--------------------------------

local tools = require("config.tools")

return {
  ----------------
  -- Mason
  --
  -- Portable package manager for Neovim that runs everywhere Neovim runs.
  -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
  --
  -- https://github.com/williamboman/mason.nvim
  ----------------
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_pending = " ",
          package_installed = " ",
          package_uninstalled = " ",
        },
      },
      registries = {
        "github:mason-org/mason-registry",
        "github:mkindberg/ghostty-ls",
      },
    },
  },

  ----------------
  -- Mason Tools Installer
  --
  -- Install and upgrade third party tools automatically
  --
  -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
  ----------------
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "mason-org/mason.nvim",
    },
    opts = {
      ensure_installed = tools.mason_tools,
    },
  },

  ----------------
  -- LSP Config
  --
  -- https://github.com/neovim/nvim-lspconfig
  ----------------
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",

      "saghen/blink.cmp",
      "b0o/schemastore.nvim",
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      vim.diagnostic.config({
        severity_sort = true,

        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
          },
          numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticLineNrError",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
          },
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP Attach",
        callback = function(ev)
          local bufmap = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
          end

          bufmap("n", "gd", vim.lsp.buf.definition, "Go to definition")
          bufmap("n", "gD", vim.lsp.buf.declaration, "Go to declaration")

          bufmap(
            "n",
            "gi",
            vim.lsp.buf.type_definition,
            "Go to type definition"
          )
          bufmap("n", "gr", function()
            Snacks.picker.lsp_references()
          end, "Show references")

          bufmap("n", "K", function()
            vim.lsp.buf.hover({ border = { { " ", "NormalFloat" } } })
          end, "Show docs")

          bufmap("n", "[g", function()
            vim.diagnostic.jump({
              count = -1,
              severity = { min = vim.diagnostic.severity.WARN },
            })
          end, "Previous diagnostic")
          bufmap("n", "]g", function()
            vim.diagnostic.jump({
              count = 1,
              severity = { min = vim.diagnostic.severity.WARN },
            })
          end, "Next diagnostic")

          bufmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
          bufmap("n", "<leader>qf", vim.lsp.buf.code_action, "Code action")
          bufmap("n", "<leader>qg", function()
            vim.lsp.buf.format({ name = "eslint", timeout_ms = 5000 })
          end, "Format")

          bufmap("n", "<space>e", vim.diagnostic.open_float, "Show line errors")
        end,
      })

      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      vim.lsp.enable(tools.lsp_configs)
    end,
  },

  ----------------
  -- Conform
  --
  -- Lightweight yet powerful formatter plugin for Neovim
  --
  -- https://github.com/stevearc/conform.nvim
  ----------------
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },

    --- @module "conform"
    --- @type conform.setupOpts
    opts = {
      formatters_by_ft = tools.conform_filetypes,
      format_on_save = {},
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2" },
        },
      },
    },
  },

  ----------------
  -- Tiny Inline Diagnostic
  --
  -- A Neovim plugin for displaying inline diagnostic messages with customizable
  -- styles and icons.
  --
  -- https://github.com/rachartier/tiny-inline-diagnostic.nvim
  ----------------
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    opts = {
      preset = "amongus",
      transparent_bg = false,
      transparent_cursorline = false,

      options = {
        show_code = false,
        override_open_float = true,
      },
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    ---@module "render-markdown"
    ---@type render.md.UserConfig
    opts = {},
    ft = { "markdown", "codecompanion" },
  },

  ----------------
  -- venv-selector.nvim
  --
  -- Allows selection of python virtual environment from within neovim
  --
  -- https://github.com/linux-cultist/venv-selector.nvim
  ----------------
  {
    "linux-cultist/venv-selector.nvim",
    ft = "python", -- Load when opening Python files
    keys = {
      { ",v", "<cmd>VenvSelect<cr>" }, -- Open picker on keymap
    },
    opts = {},
  },
}
