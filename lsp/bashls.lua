-- bashls.lua
-- Note: the filename must be the lspconfig server name (bashls), not the
-- mason package name (bash-language-server), or vim.lsp.config never reads it.

return {
    filetypes = { "sh", "bash", "zsh" },
}
