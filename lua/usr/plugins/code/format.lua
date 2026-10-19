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
        -- TODO: Do we want ruf_fix here?
        python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
        sh = { "shfmt" },
        bash = { "shfmt" },
    },
    -- Anything without a formatter above (python, lua, c, ...) formats via LSP
    default_format_opts = { lsp_format = "fallback" },
})
