-- LSP -> nvim-lspconfig
local lsp = {
  "lua_ls",
}

-- DAP -> nvim-dap

-- Linter -> ?

-- Formatter -> Conform
local prettier = { "prettierd", "prettier", stop_after_first = true }
local formatters = {
  "csharpier",
  "dcm",
  "prettier",
  "prettierd",
  -- "rustfmt",
  "stylua",
}
local conform = {
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
}

-- Syntax -> Treesitter
local syntax = {
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
}

return {
  lsp = lsp,

  formatters = formatters,
  conform = conform,

  syntax = syntax,
}
