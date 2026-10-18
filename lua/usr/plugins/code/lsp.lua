-- lsp.lua
-- LSP configuration

------------------------------------------------------------
-- Servers
------------------------------------------------------------

local servers = {
    "clangd",
    -- "basedpyright",
    "jq",
    "lua_ls",

    -- Python: pyright drives IDE features, ty the type diagnostics,
    -- ruff the lint diagnostics and fixes
    "pyright",
    "ty",
    "ruff",
    "black",
    "isort",
    "mypy",
    "flake8",

    "shellcheck",
    "shfmt",
    "bash-language-server",

    -- JavaScript / TypeScript
    "vtsls",
    "eslint-lsp",
    "oxlint",
    "prettierd",

    -- Web
    "css-lsp",
    "html-lsp",
    "json-lsp",
    "emmet-language-server",
    "tailwindcss-language-server",
}

------------------------------------------------------------
-- Plugins
------------------------------------------------------------

vim.pack.add({
    { src = "git@github.com:neovim/nvim-lspconfig" },
    { src = "git@github.com:williamboman/mason.nvim" },
    { src = "git@github.com:williamboman/mason-lspconfig.nvim" },
    { src = "git@github.com:WhoIsSethDaniel/mason-tool-installer.nvim" },
    { src = "git@github.com:b0o/SchemaStore.nvim" },
})

------------------------------------------------------------
-- Mason
------------------------------------------------------------

require('mason').setup()

require('mason-lspconfig').setup()

require('mason-tool-installer').setup({
    ensure_installed = servers
})
