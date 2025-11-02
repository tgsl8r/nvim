-- Native LSP config (requires Mason)
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.env.PYTHONPATH = table.concat({
	vim.fn.getcwd(),
	vim.fn.getcwd() .. "/src",
	vim.fn.getcwd() .. "/test",
}, ":")

local mason_bin_dir = vim.fn.expand("~/.local/share/nvim/mason/bin/")

-- C/C++
local clang_cmd = vim.fn.exists(mason_bin_dir .. "clangd") and mason_bin_dir .. "clangd" or "clangd"
vim.lsp.config["clangd"] = {
	cmd = { clang_cmd, "--offset-encoding=utf-16", "--function-arg-placeholders=0" },
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	root_markers = {
		".clangd",
		".clang-tidy",
		".clang-format",
		"compile_commands.json",
		"compile_flags.txt",
		"configure.ac",
		".git",
	},
}
vim.lsp.enable("clangd")

-- Python
local ruff_cmd = vim.fn.exists(mason_bin_dir .. "ruff") and mason_bin_dir .. "ruff" or "ruff"
vim.lsp.config["ruff"] = {
	cmd = { ruff_cmd, "server" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
}
vim.lsp.enable("ruff")

local pyright_cmd = vim.fn.exists(mason_bin_dir .. "pyright-langserver") and mason_bin_dir .. "pyright-langserver"
	or "pyright-langserver"
vim.lsp.config["pyright"] = {
	cmd = { pyright_cmd, "--stdio" },
	filetypes = { "python" },
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "openFilesOnly",
				useLibraryCodeForTypes = true,
			},
		},
	},
}
vim.lsp.enable("pyright")

-- Lua
local lua_lsp_cmd = vim.fn.exists(mason_bin_dir .. "lua-language-server") and mason_bin_dir .. "lua-language-server"
	or "lua-language-server"
vim.lsp.config["luals"] = {
	cmd = { lua_lsp_cmd },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = { "$VIMRUNTIME" },
			},
		},
	},
}
vim.lsp.enable("luals")

-- JS/TS
local ts_lsp_cmd = vim.fn.exists(mason_bin_dir .. "typescript-language-server")
		and mason_bin_dir .. "typescript-language-server"
	or "typescript-language-server"
vim.lsp.config["ts_ls"] = {
	cmd = { ts_lsp_cmd, "--stdio" },
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
}
vim.lsp.enable("ts_ls")

-- Svelte
local svelte_lsp_cmd = vim.fn.exists(mason_bin_dir .. "svelte-language-server")
		and mason_bin_dir .. "svelte-language-server"
	or "svelte-language-server"
vim.lsp.config["svelte_ls"] = {
	cmd = { svelte_lsp_cmd, "--stdio" },
	filetypes = { "svelte" },
}
vim.lsp.enable("svelte_ls")

-- CSS
local css_lsp_cmd = vim.fn.exists(mason_bin_dir .. "vscode-css-language-server")
		and mason_bin_dir .. "vscode-css-language-server"
	or "vscode-css-language-server"
vim.lsp.config["css_ls"] = {
	cmd = { css_lsp_cmd, "--stdio" },
	filetypes = { "css", "scss", "less" },
}
vim.lsp.enable("css_ls")
