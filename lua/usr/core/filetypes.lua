-- filetypes.lua

-- vtsls' "go to the implementation, not the .d.ts" command
local function goto_source_definition()
    local client = vim.lsp.get_clients({ bufnr = 0, name = "vtsls" })[1]
    if not client then
        vim.notify("vtsls is not attached to this buffer", vim.log.levels.WARN)
        return
    end
    local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
    client:exec_cmd({
        command = "typescript.goToSourceDefinition",
        arguments = { params.textDocument.uri, params.position },
    }, { bufnr = 0 })
end

-- Apply an LSP source action by kind, e.g. vtsls' source.addMissingImports.ts
local function source_action(kind)
    return function()
        vim.lsp.buf.code_action({
            context = { only = { kind }, diagnostics = {} },
            apply = true,
        })
    end
end

-- Apply automatic fixes from whichever linter LSPs are attached. Each gates
-- itself on its own config file, so a project may have any, all or none of
-- these.
local lint_fix_kinds = {
    eslint = "source.fixAll.eslint",
    oxlint = "source.fixAll.oxc",
    ruff = "source.fixAll.ruff",
}

local function lint_fix_all()
    local ran = {}

    for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        local kind = lint_fix_kinds[client.name]
        if kind then
            local last = vim.api.nvim_buf_line_count(0)
            local res = client:request_sync("textDocument/codeAction", {
                textDocument = vim.lsp.util.make_text_document_params(0),
                range = {
                    start = { line = 0, character = 0 },
                    ["end"] = { line = last, character = 0 },
                },
                context = { only = { kind }, diagnostics = {} },
            }, 5000, 0)

            for _, action in ipairs(res and res.result or {}) do
                -- eslint and oxlint inline the edit; ruff hands back a bare
                -- action that only carries its edit after codeAction/resolve
                if not action.edit and not action.command then
                    local resolved = client:request_sync("codeAction/resolve", action, 5000, 0)
                    action = (resolved and resolved.result) or action
                end

                if action.edit then
                    vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
                    ran[#ran + 1] = client.name
                elseif action.command then
                    local command = action.command
                    if type(command) == "string" then
                        command = { command = command, arguments = action.arguments }
                    end
                    client:exec_cmd(command, { bufnr = 0 })
                    ran[#ran + 1] = client.name
                end
            end
        end
    end

    if #ran == 0 then
        vim.notify("Nothing to fix (ruff, eslint, oxlint)", vim.log.levels.WARN)
    else
        vim.notify("Fixed with " .. table.concat(ran, ", "))
    end
end

-- Run the current file with the right JS runtime
local function run_js_file()
    local ext = vim.fn.expand("%:e")
    local cmd = (ext == "ts" or ext == "tsx" or ext == "mts" or ext == "cts")
        and "npx tsx"
        or "node"
    vim.cmd("!" .. cmd .. " %")
end

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
            { "n", "<leader>jf",  "<cmd>%!jq<CR>",                  "Format Buffer (jq)" },
            { "n", "<leader>jfc", "<cmd>%!jq --compact-output<CR>", "Format Buffer, Compact (jq)" },
            { "v", "<leader>jf",  ":'<,'>!jq<CR>",                  "Format Selection (jq)" },
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
