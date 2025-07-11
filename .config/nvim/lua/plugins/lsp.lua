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

      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
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
        virtual_text = {
          spacing = 4,
          prefix = "●",
          current_line = true,
        },

        severity_sort = true,

        signs = {
          linehl = {
            -- [vim.diagnostic.severity.ERROR] = "DiagnosticLineNrError",
            -- [vim.diagnostic.severity.WARN] = "DiagnosticLineNrWarn",
          },
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
          bufmap(
            "n",
            "gi",
            vim.lsp.buf.type_definition,
            "Go to type definition"
          )
          bufmap(
            "n",
            "gK",
            "<cmd>Lspsaga peek_type_definition<CR>",
            "Peek type definition"
          )
          bufmap("n", "gr", vim.lsp.buf.references, "Show references")

          bufmap("n", "K", vim.lsp.buf.hover, "Show docs")

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

          bufmap("n", "<space>e", vim.diagnostic.open_float, "Show line errors")
        end,
      })

      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
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
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    ---@module "render-markdown"
    ---@type render.md.UserConfig
    opts = {},
    enabled = true,
  },

  ----------------
  -- Aerial
  --
  -- Neovim plugin for a code outline window
  --
  -- https://github.com/stevearc/aerial.nvim
  ----------------
  {
    "stevearc/aerial.nvim",
    lazy = true,
    cmd = {
      "AerialToggle",
    },
    opts = {
      attach_mode = "global",

      layout = {
        min_width = 30,
        max_width = 50,

        placement = "edge",
        default_direction = "right",
      },
    },
  },
}
