-- ty.lua
-- Astral's type checker. Runs as the sole source of type diagnostics; pyright
-- keeps the IDE features and has its own diagnostics silenced in lsp/pyright.lua.

return {
    settings = {
        ty = {
            -- Don't compete with pyright on hover/completion/goto, which would
            -- otherwise show every result twice
            disableLanguageServices = true,
            -- Flip to "workspace" to type check the whole project rather than
            -- just open files
            diagnosticMode = "openFilesOnly",
        },
    },
}
