-- Load and configure cmake-tools
local cmake_tools_status, cmake_tools = pcall(require, "cmake-tools")
if not cmake_tools_status then
    print("Couldn't load cmake-tools")
    return
end

-- gcc/clang diagnostics plus ld errors. The explicit %t is required: without
-- it `type` is empty and every warning renders as an error. The trailing
-- %-G drops everything else (ninja/make progress, command lines, snippets).
local EFM = table.concat({
    "%f:%l:%c: fatal %trror: %m",
    "%f:%l:%c: %trror: %m",
    "%f:%l:%c: %tarning: %m",
    "%f:%l:%c: %tote: %m",
    "%f:%l:(%.%#): %m", -- ld: file:line:(.text+0x5): undefined reference
    "%-G%.%#",
}, ",")

cmake_tools.setup({
    cmake_command = "cmake",
    cmake_build_directory = "build",
    cmake_build_type = "Debug",
    cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },

    cmake_notifications = {
        enabled = true,
    },

    cmake_executor = {
        name = "overseer",
        opts = {
            new_task_opts = {
                name = "cmake",
                components = { "build_diagnostics" },
                default_component_params = { errorformat = EFM },
                strategy = { "jobstart", use_terminal = false },
            },
            -- Default opens the task list on every build; keep it in the background
            on_new_task = function() end,
        },
    },

    cmake_runner = {
        name = "terminal",
    },
})
