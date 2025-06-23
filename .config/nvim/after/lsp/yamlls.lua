--- @type vim.lsp.Config
return {
  yaml = {
    schemaStore = {
      enable = false,
      url = "",
    },
    schemas = require("schemastore").yaml.schemas(),
  },
}
