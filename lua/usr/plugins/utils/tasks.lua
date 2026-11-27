local overseer_status, overseer = pcall(require, "overseer")
if not overseer_status then
    print("Couldn't load Overseer")
    return
end

-- Shared component bundles for build tasks. Neither sets an errorformat:
-- on_output_quickfix reads it from the task's default_component_params, so
-- each caller supplies the format for its own toolchain.
--
-- `unique` disposes the previous task of the same name when a new one starts.
-- on_result_diagnostics namespaces by task name, so without it an old task
-- being disposed would wipe the newer build's diagnostics. Callers must give
-- their tasks a stable name for this to work.
local quickfix = { "on_output_quickfix", items_only = true, open_on_exit = "failure" }

overseer.setup({
    component_aliases = {
        -- Build output to the quickfix list only
        build = {
            quickfix,
            "unique",
            "default",
        },
        -- As above, plus inline diagnostics via vim.diagnostic
        build_diagnostics = {
            vim.tbl_extend("force", quickfix, { set_diagnostics = true }),
            { "on_result_diagnostics", remove_on_restart = true },
            "unique",
            "default",
        },
    },
})
