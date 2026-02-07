-- completion.lua
-- Config for completion and snippets

-- Set version of blink.cmp and its fuzzy matcher binary
BLINK_RELEASE = "v1.8.0"

------------------------------------------------------------
-- Plugins
------------------------------------------------------------

vim.pack.add({
    {
        src = "git@github.com:Saghen/blink.cmp",
        version = BLINK_RELEASE,
    },
    { src = "git@github.com:rafamadriz/friendly-snippets" },
    { src = "git@github.com:MahanRahmati/blink-nerdfont.nvim" },
})

------------------------------------------------------------
-- Configure blink
------------------------------------------------------------

local blink = require("blink.cmp")

blink.setup({
    sources = {
        default = { "lsp", "path", "snippets", "buffer", "nerdfont" },
    },
    providers = {
        nerdfont = {
          module = "blink-nerdfont",
          name = "Nerd Fonts",
        },
    },
    fuzzy = {
        implementation = "prefer_rust_with_warning",
        prebuilt_binaries = {
            download = true,
            force_version = BLINK_RELEASE,
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
