-- lsp.lua
-- LSP configuration

------------------------------------------------------------
-- Servers
------------------------------------------------------------

local servers = {
    "clangd",
    "basedpyright",
    "lua_ls",
}

------------------------------------------------------------
-- Plugins
------------------------------------------------------------

vim.pack.add({
    { src = "git@github.com:neovim/nvim-lspconfig" },
    { src = "git@github.com:williamboman/mason.nvim" },
    { src = "git@github.com:williamboman/mason-lspconfig.nvim" },
    { src = "git@github.com:WhoIsSethDaniel/mason-tool-installer.nvim" },
})

------------------------------------------------------------
-- Mason
------------------------------------------------------------

require('mason').setup()

require('mason-lspconfig').setup()

require('mason-tool-installer').setup({
    ensure_installed = servers
})
