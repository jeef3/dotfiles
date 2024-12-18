--------------------------------
-- LSP
--
-- LSP specific bits via LSP, with tools installed via Mason. Also indluces code
-- linting/formatting.
--------------------------------

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
      "soulis-1256/eagle.nvim", -- mouse hover doc
      {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim", -- Fancy virtual text for errors
        enabled = false,
        config = true,
      },
      {
        "folke/neodev.nvim",
        opts = {
          library = { plugins = { "neotest" }, types = true },
        },
      },
    },
    config = function()
      for type, icon in pairs({
        Error = " ",
        Warn = " ",
        Hint = " ",
        Info = " ",
      }) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      vim.diagnostic.config({
        update_in_insert = false,
        virtual_lines = {
          only_current_line = true,
        },
        virtual_text = {
          source = false,
          prefix = "⏹",
        },
        inlay_hints = {
          enabled = true,
        },
        float = { border = false },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP Attach",
        callback = function(ev)
          local bufmap = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
          end

          bufmap(
            "n",
            "gd",
            "<cmd>Lspsaga goto_definition<CR>",
            "Go to definition"
          )
          bufmap(
            "n",
            "gi",
            "<cmd>Lspsaga goto_type_definition<CR>",
            "Go to type definition"
          )
          bufmap(
            "n",
            "gK",
            "<cmd>Lspsaga peek_type_definition<CR>",
            "Peek type definition"
          )
          bufmap("n", "gr", "<cmd>Lspsaga finder<CR>", "Show references")

          -- bufmap("n", "K", "<cmd>Lspsaga hover_doc<CR>", "Show docs")
          bufmap("n", "K", vim.lsp.buf.hover)

          bufmap(
            "n",
            "[g",
            "<cmd>Lspsaga diagnostic_jump_prev<CR>",
            "Next diagnostic"
          )
          bufmap(
            "n",
            "]g",
            "<cmd>Lspsaga diagnostic_jump_next<CR>",
            "Previous diagnostic"
          )

          bufmap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", "Rename")
          bufmap(
            "n",
            "<leader>qf",
            "<cmd>Lspsaga code_action<CR>",
            "Code action"
          )
          bufmap("n", "<leader>o", "<cmd>Lspsaga outline<CR>", "Toggle outline")

          -- bufmap("n", "<space>e", vim.diagnostic.open_float, "Show line errors")
          bufmap(
            "n",
            "<space>e",
            "<cmd>Lspsaga show_line_diagnostics<CR>",
            "Show line errors"
          )
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
      local prettier = { "prettierd", "prettier", stop_after_first = true }

      return {
        formatters_by_ft = {
          cs = { "csharpier" },
          css = prettier,
          dart = { "dcm" },
          html = prettier,
          javascript = prettier,
          javascriptreact = prettier,
          json = prettier,
          lua = { "stylua" },
          markdown = prettier,
          rust = { "rustfmt" },
          typescript = prettier,
          typescriptreact = prettier,
          yaml = prettier,
        },
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
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "b0o/schemastore.nvim",
    },
    config = function()
      require("mason").setup()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local mason = os.getenv("HOME") .. "/.local/share/nvim/mason/bin/"

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,

        -- ["ccls"] = function()
        --   lspconfig.ccls.setup()
        -- end,

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
            cmd = { mason .. "jdtls" },
            capabilities = capabilities,
          })
        end,

        ["omnisharp"] = function()
          lspconfig.omnisharp.setup({
            cmd = { mason .. "omnisharp" },
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
