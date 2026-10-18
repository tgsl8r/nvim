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
    "js",
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
    automatic_installation = true,
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

------------------------------------------------------------
-- JavaScript / TypeScript (vscode-js-debug)
------------------------------------------------------------
-- mason-nvim-dap knows how to *install* js-debug-adapter but ships no adapter
-- or configuration mapping for it, so define them here.

local dap = require("dap")

for _, kind in ipairs({ "node", "chrome", "msedge" }) do
    local pwa = "pwa-" .. kind

    dap.adapters[pwa] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
            command = "js-debug-adapter", -- mason puts this on PATH
            args = { "${port}" },
        },
    }

    -- Accept the unprefixed types used by .vscode/launch.json
    dap.adapters[kind] = function(cb, config)
        config.type = pwa
        cb(dap.adapters[pwa])
    end
end

local js_filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }

local vscode = require("dap.ext.vscode")
vscode.type_to_filetypes["node"] = js_filetypes
vscode.type_to_filetypes["pwa-node"] = js_filetypes

local js_skip = { "<node_internals>/**", "node_modules/**" }
local js_sourcemaps = { "${workspaceFolder}/**", "!**/node_modules/**" }

for _, ft in ipairs(js_filetypes) do
    -- TS can't be run by node directly; prefer tsx, fall back to ts-node
    local runtime = nil
    if ft:find("typescript") then
        runtime = vim.fn.executable("tsx") == 1 and "tsx" or "ts-node"
    end

    dap.configurations[ft] = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch File (node)",
            program = "${file}",
            cwd = "${workspaceFolder}",
            runtimeExecutable = runtime,
            sourceMaps = true,
            skipFiles = js_skip,
            resolveSourceMapLocations = js_sourcemaps,
        },
        {
            type = "pwa-node",
            request = "attach",
            name = "Attach to Process (node)",
            processId = function() return require("dap.utils").pick_process() end,
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            skipFiles = js_skip,
            resolveSourceMapLocations = js_sourcemaps,
        },
        {
            type = "pwa-chrome",
            request = "launch",
            name = "Launch Chrome (vite dev server)",
            url = function()
                return vim.fn.input("URL: ", "http://localhost:5173")
            end,
            webRoot = "${workspaceFolder}",
            sourceMaps = true,
            skipFiles = js_skip,
            resolveSourceMapLocations = js_sourcemaps,
        },
    }
end
