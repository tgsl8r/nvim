-- pyright.lua
-- completion, hover, goto, etc.

return {
    filetypes = { "python" },
    settings = {
        python = {
            analysis = {
                -- No type diags (ty does it)
                ignore = { "*" },
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
            },
        },
    },
}
