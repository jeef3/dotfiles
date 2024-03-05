return {
  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    dependencies = {
      "nvim-lua/plenary.nvim",

      "hrsh7th/cmp-nvim-lsp",
      -- "nvimdev/lspsaga.nvim",
      "nvimtools/none-ls.nvim",
      "nvim-tree/nvim-web-devicons",

      {
        "folke/neodev.nvim",
        opts = {
          library = { plugins = { "neotest" }, types = true },
        },
      },

      "mason.nvim",
      "mason-lspconfig.nvim",
    },

    opts = {
      underline = true,
    }
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      local lspconfig = require("lspconfig")
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,

        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            -- on_attach = on_attach,
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
    end
  }
}
