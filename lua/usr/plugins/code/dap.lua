-- dap.lua
-- DAP configuration

------------------------------------------------------------
-- Adapters
------------------------------------------------------------

local adapters = {
    "python",
}

------------------------------------------------------------
-- Plugins
------------------------------------------------------------

vim.pack.add({
    { src = "git@github.com:mfussenegger/nvim-dap" },
    { src = "git@github.com:jay-babu/mason-nvim-dap.nvim" },
})

------------------------------------------------------------
-- Mason
------------------------------------------------------------

require('mason-nvim-dap').setup({
    ensure_installed = adapters
})
