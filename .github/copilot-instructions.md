# Copilot instructions for this repository

When working in this repository, prefer language-server-backed code intelligence before text search.

1. For symbol lookups, definitions, references, call graphs, and type information, use LSP tools first.
2. Use file name search (`glob`) only when locating candidate files or when LSP is unavailable for that language.
3. Use content search (`rg`) as a fallback after LSP/glob, not as the first option for symbol-level questions.
4. If an LSP request fails, state that briefly and fall back to `glob` then `rg`.
