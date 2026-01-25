-- dap.lua
-- DAP configuration

------------------------------------------------------------
-- Adapters
------------------------------------------------------------

local adapters = {
    "codelldb",
    "bash",
    "haskell",
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
-- Configure and setup
------------------------------------------------------------

require('mason-nvim-dap').setup({
    ensure_installed = adapters,
    handlers = {
        function(config)
            -- Default adapter config
            require('mason-nvim-dap').default_setup(config)
        end,
        -- Custom config
        -- python = function(config)
        --     config.adapters = {
        --      type = "executable",
        --      command = "/usr/bin/python3",
        --      args = {
        --       "-m",
        --       "debugpy.adapter",
        --      },
        --     }
        --     require('mason-nvim-dap').default_setup(config)
        -- end,
    },
})
