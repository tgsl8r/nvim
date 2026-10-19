-- actions.lua
-- LSP source actions: lint fixes, etc

local M = {}

-- vtsls' "go to the implementation, not the .d.ts" command
function M.goto_source_definition()
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

-- Run the current file with the right JS runtime
function M.run_js_file()
    local ext = vim.fn.expand("%:e")
    local cmd = (ext == "ts" or ext == "tsx" or ext == "mts" or ext == "cts")
        and "npx tsx"
        or "node"
    vim.cmd("!" .. cmd .. " %")
end

-- Action family -> LSP name -> code action kind.
M.kinds = {
    fix_all = {
        ruff = "source.fixAll.ruff",
        eslint = "source.fixAll.eslint",
        oxlint = "source.fixAll.oxc",
    },
    organize_imports = {
        ruff = "source.organizeImports.ruff",
        vtsls = "source.organizeImports",
    },
    add_missing_imports = {
        vtsls = "source.addMissingImports.ts",
    },
    remove_unused = {
        vtsls = "source.removeUnused.ts",
    },
}

local TIMEOUT = 5000

--- Apply one action family across every attached client that supports it.
--- @param family string Key of M.kinds
--- @param opts? table { bufnr?: integer, notify?: boolean }
--- @return string[] clients that applied something
function M.apply(family, opts)
    opts = opts or {}
    local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
    local notify = opts.notify ~= false
    local kinds = M.kinds[family] or {}
    local label = family:gsub("_", " ")

    local ran = {}
    local last = vim.api.nvim_buf_line_count(bufnr)

    for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
        local kind = kinds[client.name]
        if kind then
            local res = client:request_sync("textDocument/codeAction", {
                textDocument = vim.lsp.util.make_text_document_params(bufnr),
                range = {
                    start = { line = 0, character = 0 },
                    ["end"] = { line = last, character = 0 },
                },
                context = { only = { kind }, diagnostics = {} },
            }, TIMEOUT, bufnr)

            for _, action in ipairs(res and res.result or {}) do
                -- eslint and oxlint inline the edit; ruff hands back a bare action
                if not action.edit and not action.command then
                    local resolved = client:request_sync("codeAction/resolve", action, TIMEOUT, bufnr)
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
                    client:exec_cmd(command, { bufnr = bufnr })
                    ran[#ran + 1] = client.name
                end
            end
        end
    end

    if notify then
        if #ran == 0 then
            vim.notify("No " .. label .. " available here", vim.log.levels.WARN)
        else
            vim.notify(label .. ": " .. table.concat(ran, ", "))
        end
    end

    return ran
end

--- @param opts? table
function M.fix_all(opts)
    return M.apply("fix_all", opts)
end

--- @param opts? table
function M.organize_imports(opts)
    return M.apply("organize_imports", opts)
end

--- @param opts? table
function M.add_missing_imports(opts)
    return M.apply("add_missing_imports", opts)
end

--- @param opts? table
function M.remove_unused(opts)
    return M.apply("remove_unused", opts)
end

------------------------------------------------------------
-- Commands
------------------------------------------------------------

local commands = {
    LintFix = { M.fix_all, "Apply every available lint fix" },
    OrganizeImports = { M.organize_imports, "Sort and prune imports" },
    AddMissingImports = { M.add_missing_imports, "Import unresolved symbols" },
    RemoveUnused = { M.remove_unused, "Strip unused code" },
}

for name, spec in pairs(commands) do
    local fn, desc = spec[1], spec[2]
    vim.api.nvim_create_user_command(name, function()
        fn()
    end, { desc = desc })
end

return M
