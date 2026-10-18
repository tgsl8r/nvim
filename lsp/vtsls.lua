-- vtsls.lua
-- Settings only: nvim-lspconfig supplies cmd/filetypes and the monorepo-aware
-- root_dir, and sets no `settings` key, so this merges cleanly on top.

local inlay_hints = {
    enumMemberValues = { enabled = true },
    functionLikeReturnTypes = { enabled = true },
    parameterNames = { enabled = "literals" },
    parameterTypes = { enabled = true },
    propertyDeclarationTypes = { enabled = true },
    variableTypes = { enabled = false },
}

return {
    settings = {
        complete_function_calls = true,
        vtsls = {
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
            experimental = {
                maxInlayHintLength = 30,
                completion = { enableServerSideFuzzyMatch = true },
            },
        },
        typescript = {
            -- Lets Snacks.rename.rename_file rewrite imports project-wide
            updateImportsOnFileMove = { enabled = "always" },
            suggest = { completeFunctionCalls = true },
            inlayHints = inlay_hints,
        },
        javascript = {
            updateImportsOnFileMove = { enabled = "always" },
            inlayHints = inlay_hints,
        },
    },
}
