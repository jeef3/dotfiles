----------------
-- LSP Config
--
-- https://github.com/neovim/nvim-lspconfig
----------------

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",

      "nvimdev/lspsaga.nvim",
      "nvimtools/none-ls.nvim",

      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",

      {
        "folke/neodev.nvim",
        opts = {
          library = { plugins = { "neotest" }, types = true },
        },
      },

      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
      },
      inlay_hints = {
        enabled = false,
      },
      codelens = {
        enabled = false,
      },
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
    },
    config = function(_, opts)
      for type, icon in pairs({
        Error = " ",
        Warn = " ",
        Hint = " ",
        Info = " ",
      }) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        { virtual_text = { prefix = "⏹" } }
      )

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP Attach",
        callback = function()
          local bufmap = function(mode, lhs, rhs)
            vim.keymap.set(mode, lhs, rhs, { buffer = true })
          end

          bufmap("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
          bufmap("n", "gi", "<cmd>Lspsaga goto_type_definition<CR>")
          bufmap("n", "gK", "<cmd>Lspsaga peek_type_definition<CR>")
          bufmap("n", "gr", "<cmd>Lspsaga finder<CR>")

          bufmap("n", "K", "<cmd>Lspsaga hover_doc<CR>")
          -- bufmap("n", "K", vim.lsp.buf.hover)

          bufmap("n", "[g", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
          bufmap("n", "]g", "<cmd>Lspsaga diagnostic_jump_next<CR>")

          bufmap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>")
          bufmap("n", "<leader>qf", "<cmd>Lspsaga code_action<CR>")
          bufmap("n", "<leader>o", "<cmd>Lspsaga outline<CR>")

          bufmap("n", "<space>e", "<cmd>Lspsaga show_line_diagnostics<CR>")
        end,
      })
    end,
  },
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
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        -- yaml = { "yamlfmt" },
        javascript = { { "prettierd", "prettier" } },
        javascriptreact = { { "prettierd", "prettier" } },
        typescript = { { "prettierd", "prettier" } },
        typescriptreact = { { "prettierd", "prettier" } },
      },
      format_on_save = {
        timeout_ms = 500,
        lps_fallback = true,
      },
    },
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local omnisharp_bin = os.getenv("HOME")
        .. "/.local/share/nvim/mason/bin/omnisharp"
      local java_bin = os.getenv("HOME") .. "/.local/share/nvim/mason/bin/jdtls"

      require("mason-lspconfig").setup_handlers({
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

        ["jdtls"] = function()
          lspconfig.jdtls.setup({
            cmd = { java_bin },
            capabilities = capabilities,
          })
        end,

        ["omnisharp"] = function()
          lspconfig.omnisharp.setup({
            cmd = { omnisharp_bin },
            capabilities = capabilities,
          })
        end,

        ["yamlls"] = function()
          lspconfig.yamlls.setup({
            settings = {
              yaml = {
                schemas = {
                  ["https://bitbucket.org/atlassianlabs/atlascode/raw/main/resources/schemas/pipelines-schema.json"] = "./bitbucket-pipelines.yml",
                  ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.0/schema.yaml"] = "./schema.yml",
                },
              },
            },
            capabilities = capabilities,
          })
        end,
      })
    end,
  },
}
