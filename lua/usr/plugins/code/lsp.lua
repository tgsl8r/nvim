-- lsp.lua
-- LSP configuration

------------------------------------------------------------
-- Servers
------------------------------------------------------------

local servers = {
    -- C / C++ / CMake
    "clangd",
    "clang-format",
    "neocmakelsp",
    "gersemi",

    -- Python
    "pyright",
    "ty",
    "ruff",
    "black",
    "isort",
    "mypy",
    "flake8",

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

    -- Shell / data
    "shellcheck",
    "shfmt",
    "bash-language-server",
    "jq",

    -- Others : )
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

------------------------------------------------------------
-- Overrides
------------------------------------------------------------
-- vim.lsp.config() is the top precedence tier and can't be clobbered by defaults

vim.lsp.config("clangd", {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
    },
})
