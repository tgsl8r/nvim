-- completion.lua
-- Config for completion and snippets

------------------------------------------------------------
-- Plugins
------------------------------------------------------------

vim.pack.add({
    {
        src = "git@github.com:Saghen/blink.cmp",
        version = "v1.8.0",
        build = "cargo build --release"
    },
    { src = "git@github.com:rafamadriz/friendly-snippets" },
})

------------------------------------------------------------
-- Configure blink
------------------------------------------------------------

local blink = require("blink.cmp")

blink.setup({
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = {
        -- TODO: Sort out rust binary and switch to prefer_rust_with_warning
        implementation = "prefer_rust",
        prebuilt_binaries = {
            download = true,
            ignore_version_mismatch = true,
        },
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
