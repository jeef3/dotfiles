-- Mason
local mason_tools = {
  -- LSP
  "bash-language-server",
  "deno",
  "lemminx",
  "json-lsp", -- jsonls
  "lua-language-server",
  "pyright",
  "typescript-language-server", -- ts_ls
  "yaml-language-server", -- yamlls

  -- Formatters
  "csharpier",
  "prettier",
  "prettierd",
  "stylua",

  -- Linters
  "stylelint",
}

-- DAP -> nvim-dap

-- Formatter -> Conform
local prettier = { "prettierd", "prettier", stop_after_first = true }
local conform = {
  cs = { "csharpier" },
  css = prettier,
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
}

return {
  mason_tools = mason_tools,

  conform = conform,

  syntax = syntax,
}
