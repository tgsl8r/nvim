local mason_status, mason = pcall(require, "mason")
if not mason_status then
	print("Couldn't load mason")
	return
end

mason.setup()

local mason_registry_status, mason_registry = pcall(require, "mason-registry")
if not mason_registry_status then
	print("Couldn't load mason registry")
	return
end

local lsp = {
	"clangd",
	"css-lsp",
	"lua-language-server",
	"basedpyright",
	"ruff",
	"svelte-language-server",
	"typescript-language-server",
}

local dap = {}
local linter = { "bandit", "ruff" }
local formatter = {
	"stylua",
	"ruff",
	"prettier",
	"clang-format",
	"fixjson",
	"verible",
}

local servers = {}
vim.list_extend(servers, lsp)
vim.list_extend(servers, dap)
vim.list_extend(servers, linter)
vim.list_extend(servers, formatter)

for _, name in ipairs(servers) do
	local pkg = mason_registry.get_package(name)
	if not pkg:is_installed() then
		print("Mason installing " .. name)
		pkg:install()
	end
end
