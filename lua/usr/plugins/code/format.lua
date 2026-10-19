-- format.lua
-- Formatter configuration

------------------------------------------------------------
-- Plugins
------------------------------------------------------------

vim.pack.add({
    { src = "git@github.com:stevearc/conform.nvim" },
})

------------------------------------------------------------
-- Config
------------------------------------------------------------

-- biome -> project-local prettier -> mason prettierd.
-- biome and prettier resolve via node_modules/.bin, so they are simply
-- unavailable outside projects that depend on them and stop_after_first
-- falls through to the next one.
local web = { "biome", "prettier", "prettierd", stop_after_first = true }

require("conform").setup({
    formatters_by_ft = {
        javascript = web,
        javascriptreact = web,
        typescript = web,
        typescriptreact = web,
        css = web,
        scss = web,
        less = web,
        html = web,
        json = web,
        jsonc = web,
        yaml = web,
        graphql = web,
        markdown = web,
        python = { "ruff_format" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        cmake = { "gersemi" },
        sh = { "shfmt" },
        bash = { "shfmt" },
    },
    default_format_opts = { lsp_format = "fallback" },
    -- TODO: Format on save?
    -- format_on_save = { timeout_ms = 1000, lsp_format = "fallback" },
})
