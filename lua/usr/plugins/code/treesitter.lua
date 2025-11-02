local treesitter_status, treesitter = pcall(require, "nvim-treesitter.configs")
if not treesitter_status then
	print("Couldn't load treesitter")
	return
end

treesitter.setup({
	highlight = {
		enable = true,
		disable = { "large_file" },
	},
	incremental_selection = { enable = true },
	textobjects = {
		enable = true,
		move = {
			enable = true,
			goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
			goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
			goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
			goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
		},
	},
	indent = { enable = true },
	matchup = {
		enable = true,
	},
	ensure_installed = {
		"json",
		"markdown",
		"markdown_inline",
		"bash",
		"lua",
		"vim",
		"dockerfile",
		"gitignore",
		"yaml",
    "toml",
		"html",
		"css",
		"javascript",
		"typescript",
		"python",
    "c",
    "cpp",
	},
	auto_install = true,
})
