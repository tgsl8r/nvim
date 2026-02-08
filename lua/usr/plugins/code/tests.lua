-- tests.lua
-- Config for neotest and adapters

------------------------------------------------------------
-- Plugins
------------------------------------------------------------

vim.pack.add({
	{ src = "git@github.com:nvim-neotest/neotest" },
	{ src = "git@github.com:orjangj/neotest-ctest" },
	{ src = "git@github.com:nvim-neotest/neotest-python" },
})

------------------------------------------------------------
-- Config
------------------------------------------------------------

local neotest = require("neotest")
local ctest = require("neotest-ctest")

neotest.setup({
	adapters = {
        ctest.setup({
			build_dir = "build",
            ctest_command = "ctest --output-on-failure",
		}),
	},
})
