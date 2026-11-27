-- filetypes.lua

local actions = require("usr.plugins.code.actions")

local filetype_configs = {
    -- Previewable files
    {
        pattern = { "markdown", "html", "asciidoc", "svg" },
        opts = {
            wrap = true,
        },
        keymaps = {
            { "n", "<leader>ps", "<cmd>LivePreview start<cr>", "Live preview: start" },
            { "n", "<leader>pc", "<cmd>LivePreview close<cr>", "Live preview: close" },
            { "n", "<leader>pp", "<cmd>LivePreview pick<cr>", "Live preview: pick file" },
        },
    },

    -- Markdown files
    {
        pattern = { "markdown", "markdown.mdx" },
        opts = {
            wrap = true,
            conceallevel = 2,
        },
        keymaps = {},
    },

    -- Shell files
    {
        pattern = { "sh", "bash", "zsh", "fish" },
        opts = {},
        keymaps = {
            { "n", "<leader>R", ":!/bin/sh %<CR>", "Run File (shell)" },
        },
    },

    -- HTML files
    {
        pattern = "html",
        opts = {
            wrap = true,
        },
        keymaps = {},
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
            { "n", "<leader>R", ":luafile %<CR>", "Run File (Lua)" },
        },
    },

    -- Python files
    {
        pattern = "python",
        opts = {},
        keymaps = {
            { "n", "<leader>R", ":!python3 %<CR>", "Run File (Python)" },
        },
    },

    -- JavaScript / TypeScript files
    {
        pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
        opts = {},
        keymaps = {
            { "n", "<leader>R",  actions.run_js_file,            "Run File (Node)" },
            { "n", "<leader>ci", actions.add_missing_imports,    "Add Missing Imports" },
            { "n", "<leader>cu", actions.remove_unused,          "Remove Unused" },
            { "n", "<leader>cS", actions.goto_source_definition, "Goto Source Definition" },
        },
    },
    -- JSON files
    {
        pattern = "json",
        opts = {},
        keymaps = {
            { "n", "<leader>jf",  "<cmd>%!jq<CR>",                  "Format Buffer (jq)" },
            { "n", "<leader>jfc", "<cmd>%!jq --compact-output<CR>", "Format Buffer, Compact (jq)" },
            { "v", "<leader>jf",  ":'<,'>!jq<CR>",                  "Format Selection (jq)" },
            { "v", "<leader>jfc", ":'<,'>!jq --compact-output<CR>", "Format Selection, Compact (jq)" },
        },
    },
}

local group = vim.api.nvim_create_augroup("filetype_configs", { clear = true })

-- Create autocmds
for _, config in ipairs(filetype_configs) do
    vim.api.nvim_create_autocmd("FileType", {
        group = group,
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
