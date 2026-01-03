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
-- Load snippets
------------------------------------------------------------

vim.snippet.loaders.from_vscode.lazy_load()

------------------------------------------------------------
-- Configure blink
------------------------------------------------------------

local blink = require("blink.cmp")

blink.setup({
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
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
