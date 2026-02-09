-- filetypes.lua

local filetype_configs = {
    -- Markdown files
    {
        pattern = { "markdown", "markdown.mdx" },
        opts = {
            wrap = true,
        },
        keymaps = {
            { "n", "<leader>r", ":LivePreview start<CR>", "Render File (live)" },
        },
    },

    -- Shell files
    {
        pattern = { "sh", "bash", "zsh", "fish" },
        opts = {},
        keymaps = {
            { "n", "<leader>r", ":!/bin/sh %<CR>", "Run File (shell)" },
        },
    },

    -- HTML files
    {
        pattern = "html",
        opts = {
            wrap = true,
        },
        keymaps = {
            { "n", "<leader>r", ":LivePreview start<CR>", "Render File (live)" },
        },
    },

    -- Makefiles
    {
        pattern = "make",
        opts = {
            expandtab = false
        },
        keymaps = {},
    },

    -- Lua files
    {
        pattern = "lua",
        opts = {},
        keymaps = {
            { "n", "<leader>r", ":luafile %<CR>", "Run File (Lua)" },
        },
    },

    -- Python files
    {
        pattern = "python",
        opts = {},
        keymaps = {
            { "n", "<leader>r", ":!python3 %<CR>", "Run File (Python)" },
        },
    },

    -- JavaScript / TypeScript files
    {
        pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
        opts = {},
        keymaps = {
            { "n", "<leader>r", ":!node %<CR>", "Run File (Node)" },
        },
    },
    -- JSON files
    {
        pattern = "json",
        opts = {},
        keymaps = {
            { "n", "<leader>jf", "<cmd>%!jq<CR>", "Format Buffer (jq)" },
            { "n", "<leader>jfc", "<cmd>%!jq --compact-output<CR>", "Format Buffer, Compact (jq)" },
            { "v", "<leader>jf", ":'<,'>!jq<CR>", "Format Selection (jq)" },
            { "v", "<leader>jfc", ":'<,'>!jq --compact-output<CR>", "Format Selection, Compact (jq)" },
        },
    },
}

-- Create autocmds
for _, config in ipairs(filetype_configs) do
    vim.api.nvim_create_autocmd("FileType", {
        pattern = config.pattern,
        callback = function()
            -- Set buffer-local options
            if config.opts then
                for k, v in pairs(config.opts) do
                    vim.opt_local[k] = v
                end
            end

            -- Set buffer-local keymaps
            if config.keymaps then
                for _, km in ipairs(config.keymaps) do
                    local mode, keys, map, desc = unpack(km)
                    vim.keymap.set(mode, keys, map, { buffer = true, desc = desc })
                end
            end
        end,
    })
end
