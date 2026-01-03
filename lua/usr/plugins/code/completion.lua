-- completion.lua
-- Config for completion and snippets

------------------------------------------------------------
-- Plugins
------------------------------------------------------------

vim.pack.add({
    { src = "git@github.com:Saghen/blink.cmp" },
    { src = "git@github.com:rafamadriz/friendly-snippets" },
})

------------------------------------------------------------
-- Configure blink
------------------------------------------------------------

local blink = require("blink.cmp")

blink.setup({
    version = "*",
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = {
        implementation = "prefer_rust_with_warning",
    },
    keymap = {
        ["<Tab>"] = {
            "snippet_forward",
            "select_next",
            "fallback",
        },
        ["<S-Tab>"] = {
            "snippet_backward",
            "select_prev",
            "fallback",
        },
        ["<CR>"] = {
            "accept",
            "fallback",
        },
    },
})
