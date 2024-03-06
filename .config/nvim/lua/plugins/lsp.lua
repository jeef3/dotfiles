return {
  {
    "neovim/nvim-lspconfig",
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
      "williamboman/mason-lspconfig.nvim",
    },
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local omnisharp_bin = "/Users/jeffknaggs/.local/share/nvim/mason/bin/omnisharp"
      local java_bin = "/Users/jeffknaggs/.local/share/nvim/mason/bin/jdtls"

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
    end
  }
}
