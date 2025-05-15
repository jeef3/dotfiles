--------------------------------
-- LSP
--
-- LSP specific bits via LSP, with tools installed via Mason. Also indluces code
-- linting/formatting.
--------------------------------

local tools = require("config.tools")

return {
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

      "nvimdev/lspsaga.nvim",

      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "b0o/schemastore.nvim",
      {
        "folke/neodev.nvim",
        opts = {
          library = { plugins = { "neotest" }, types = true },
        },
      },
    },
    config = function()
      vim.diagnostic.config({
        update_in_insert = false,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
          },
        },
        virtual_lines = {
          current_line = true,
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

          bufmap("n", "K", vim.lsp.buf.hover)

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
          -- bufmap("n", "<leader>o", "<cmd>Lspsaga outline<CR>", "Toggle outline")

          bufmap("n", "<space>e", vim.diagnostic.open_float, "Show line errors")
        end,
      })
    end,
  },

  ----------------
  -- LSP Saga
  --
  -- Improve neovim lsp experience
  --
  -- https://github.com/nvimdev/lspsaga.nvim
  ----------------
  {
    "nvimdev/lspsaga.nvim",
    enabled = false,
    opts = {
      code_action = {},
      lightbulb = { enable = false },
      finder = {
        max_height = 0.8,
        force_max_height = true,
        layout = "float",
      },
      outline = {
        win_width = 5,
        auto_preview = false,
      },
      ui = {
        title = true,
        border = "rounded",
        winblend = 5,
        expand = "",
        collapse = "",
        preview = " ",
        code_action = "💡",
        hover = " ",
      },
      symbol_in_winbar = { enable = true, separator = "  " },
    },
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
    opts = {
      on_attach = function(buf)
        vim.keymap.set(
          "n",
          "<leader>o",
          "<cmd>AerialToggle!<CR>",
          { buffer = buf, desc = "Toggle outline" }
        )
      end,
      attach_mode = "global",

      layout = {
        min_width = 30,
        max_width = 50,

        placement = "edge",
        default_direction = "right",
      },
    },
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
    opts = function()
      return {
        formatters_by_ft = tools.conform,
        format_on_save = function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 1000, lsp_format = "fallback" }
        end,
      }
    end,
    init = function()
      vim.api.nvim_create_user_command("ConformDisable", function(args)
        if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })
      vim.api.nvim_create_user_command("ConformEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })
    end,
  },

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
    version = "^1.0.0",
    dependencies = {
      { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "b0o/schemastore.nvim",
    },
    config = function()
      require("mason").setup()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("mason-tool-installer").setup({
        ensure_installed = tools.formatters,
      })

      local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"

      mason_lspconfig.setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,

        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim" } },
                workspace = {
                  library = vim.api.nvim_get_runtime_file("", true),
                  checkThirdParty = false,
                },
                telemetry = { enable = false },
                completion = {
                  callSnippet = "Replace",
                },
              },
            },
          })
        end,

        ["jsonls"] = function()
          lspconfig.jsonls.setup({
            capabilities = capabilities,
            settings = {
              json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
              },
            },
          })
        end,

        ["jdtls"] = function()
          lspconfig.jdtls.setup({
            cmd = { mason_bin .. "jdtls" },
            capabilities = capabilities,
          })
        end,

        ["omnisharp"] = function()
          lspconfig.omnisharp.setup({
            cmd = { mason_bin .. "omnisharp" },
            capabilities = capabilities,
            settings = {
              MsBuild = {
                LoadProjectsOnDemand = true,
              },
            },
          })
        end,

        ["stylelint_lsp"] = function()
          lspconfig.stylelint_lsp.setup({
            settings = {
              stylelintplus = {
                autoFixOnFormat = true,
                autoFixOnSave = true,
              },
            },
          })
        end,

        ["yamlls"] = function()
          lspconfig.yamlls.setup({
            settings = {
              yaml = {
                schemaStore = {
                  enable = false,
                  url = "",
                },
                schemas = require("schemastore").yaml.schemas(),
              },
            },
            capabilities = capabilities,
          })
        end,
      })
    end,
  },

  ----------------
  -- Flutter Tools
  --
  -- Tools to help create flutter apps in neovim using the native lsp.
  --
  -- https://github.com/nvim-flutter/flutter-tools.nvim
  ----------------
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    config = { fvm = true },
  },

  ----------------
  -- Pubspec Assist
  --
  -- https://github.com/nvim-flutter/pubspec-assist.nvim
  ----------------
  {
    "akinsho/pubspec-assist.nvim",
    requires = "plenary.nvim",
    config = true,
  },

  ----------------
  -- Fidget
  --
  -- 💫 Extensible UI for Neovim notifications and LSP progress messages.
  --
  -- https://github.com/j-hui/fidget.nvim
  ----------------
  {
    "j-hui/fidget.nvim",
    opts = {
      -- options
    },
  },
}
