# User-level Copilot instructions

Prefer language-server-backed code intelligence over text search tools.

1. For symbol lookups, definitions, references, call graphs, and type information, use LSP tools first.
2. Use file name search (`fd`) only when locating candidate files or when LSP is unavailable for that language.
3. Use content search (`ag`) as a fallback after LSP/fd, not as the first option for symbol-level questions.
4. If an LSP request fails, state that briefly and fall back to `fd` then `ag`.
