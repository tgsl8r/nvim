-- tests.lua
-- Config for neotest and adapters

------------------------------------------------------------
-- Plugins
------------------------------------------------------------

vim.pack.add({
	{ src = "git@github.com:nvim-neotest/neotest" },
	{ src = "git@github.com:orjangj/neotest-ctest" },
	{ src = "git@github.com:nvim-neotest/neotest-python" },
	{ src = "git@github.com:nvim-neotest/neotest-jest" },
	{ src = "git@github.com:marilari88/neotest-vitest" },
})

------------------------------------------------------------
-- Config
------------------------------------------------------------

local neotest = require("neotest")
local ctest = require("neotest-ctest")
local neotest_python = require("neotest-python")
local neotest_jest = require("neotest-jest")
-- Gates itself on vitest appearing in package.json deps, so it won't
-- collide with the jest adapter above
local neotest_vitest = require("neotest-vitest")

neotest.setup({
	adapters = {
        ctest.setup({
			build_dir = "build",
            ctest_command = "ctest --output-on-failure",
		}),
        neotest_python({
            dap = { justMyCode = true },
            args = { "-s", "-v", "--log-level", "DEBUG" },
            env = {
                TEST = "True",
                TEST_MODE = "True",
                DRYRUN = "True",
                READONLY = "True",
                SLACK_OUTPUT = "False",
            },
            runner = "pytest",
            is_test_file = function(file_path)
                return string.match(file_path, ".-/tests?/.*test[%w_]+%.py$")
                    or string.match(file_path, ".-/testint/.*test[%w_]+%.py$")
                    or string.match(file_path, ".-/test%-integration/test[%w_]+%.py$")
            end,
            pytest_discover_instances = false,
        }),
        neotest_jest({
            env = { TEST_MODE = true },
            isTestFile = function(file_path)
                return string.match(file_path, "/tests?/.*[^/]%.test%.[jt]sx?$")
            end,
        }),
        neotest_vitest,
	},
    summary = {
        mappings = {
            expand = "<CR>",
            stop = "x",
            run = "r",
            run_marked = "R",
            mark = "m",
            clear_marked = "M",
            output = "O",
            short = "s",
            attach = "a",
            jumpto = "o",
        },
    },
})
