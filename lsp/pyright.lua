-- pyright.lua
-- Kept for completion, hover and goto. ty owns the type diagnostics, so
-- pyright is told to report none rather than duplicating every error.
--
-- This has to go through pyright's own `ignore` setting: pyright serves
-- diagnostics over pull (textDocument/diagnostic), so overriding the
-- textDocument/publishDiagnostics handler silently does nothing.

return {
    filetypes = { "python" },
    settings = {
        python = {
            analysis = {
                ignore = { "*" },
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
            },
        },
    },
}
