local prettier_def = { "prettierd", "prettier", stop_after_first = true }

return {
  -- LSP configs as per nvim-lspconfig
  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
  lsp_configs = {
    "bashls",
    "denols",
    "jsonls",
    "lemminx",
    "lua_ls",
    "omnisharp",
    "prismals",
    "pyright",
    "sourcekit",
    "ts_ls",
    "yamlls",
  },

  -- Mason tools as per mason-registry
  -- https://github.com/mason-org/mason-registry/tree/main/packages
  mason_tools = {
    -- LSP
    "bash-language-server", -- bashls
    "deno", -- denols
    "lemminx", -- lemminx
    "json-lsp", -- jsonls
    "lua-language-server", -- lua_ls
    "omnisharp", -- omnisharp
    "prisma-language-server", -- prismals
    "pyright", --pyright
    "typescript-language-server", -- ts_ls
    "yaml-language-server", -- yamlls

    -- Formatters
    "beautysh",
    "csharpier",
    "prettier",
    "prettierd",
    "stylua",

    -- Linters
    "eslint_d",
    "luacheck",
    "jsonlint",
    "mypy",
    "stylelint",
  },

  -- DAP -> nvim-dap

  conform_filetypes = {
    cs = { "csharpier" },
    css = prettier_def,
    html = prettier_def,
    javascript = prettier_def,
    javascriptreact = prettier_def,
    json = prettier_def,
    graphql = prettier_def,
    lua = { "stylua" },
    markdown = prettier_def,
    python = prettier_def,
    rust = { "rustfmt" },
    typescript = prettier_def,
    typescriptreact = prettier_def,
    yaml = prettier_def,
  },

  treesitter_syntaxes = {
    "arduino",
    "bash",
    "c",
    "c_sharp",
    "cmake",
    "cpp",
    "css",
    "csv",
    "dart",
    "diff",
    "dockerfile",
    "embedded_template",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "go",
    "graphql",
    "haskell",
    "html",
    "java",
    "javascript",
    "jq",
    "jsdoc",
    "json",
    "json5",
    "jsonc",
    "lua",
    "luadoc",
    "luap",
    "make",
    "markdown",
    "markdown_inline",
    "prisma",
    "python",
    "query",
    "regex",
    "ruby",
    "rust",
    "scss",
    "swift",
    "tmux",
    "todotxt",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "xml",
    "yaml",
  },
}
