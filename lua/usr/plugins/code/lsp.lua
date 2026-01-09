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
})

------------------------------------------------------------
-- Mason
------------------------------------------------------------

require('mason').setup()

require('mason-lspconfig').setup({
  ensure_installed = servers,
  automatic_installation = true,
})

------------------------------------------------------------
-- Load config and enable servers
------------------------------------------------------------

for _, server in ipairs(servers) do
  vim.lsp.config(server, {
    on_attach = on_attach,
  })
end

vim.lsp.enable(servers)
