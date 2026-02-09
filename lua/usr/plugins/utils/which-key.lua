local whichkey_status, whichkey = pcall(require, "which-key")
if not whichkey_status then
	print("Couldn't load which-key")
	return
end

vim.o.timeout = true
vim.o.timeoutlen = 300

whichkey.setup({
	preset = "helix",
	defaults = {},
	spec = {
		mode = { "n", "v" },
		{ "[", group = "prev" },
		{ "]", group = "next" },
		{ "g", group = "goto" },
		{ "<leader><tab>", group = "tabs" },
		{ "<leader>f", group = "files" },
        { "<leader>w", group = "windows", expand = function()
            return require("which-key.extras").expand.win()
        end },
		{ "<leader>wt", group = "terminal" },
		{ "<leader>ws", group = "scratch" },
        { "<leader>b", group = "buffers", expand = function()
            return require("which-key.extras").expand.buf()
        end },
		{ "<leader>s", group = "search/show" },
		{ "<leader>c", group = "code" },
		{ "<leader>g", group = "git" },
		{ "<leader>gh", group = "hunk" },
		{ "<leader>l", group = "list" },
		{ "<leader>h", group = "history" },
		{ "<leader>d", group = "debug" },
		{ "<leader>dp", group = "profiling" },
		{ "<leader>t", group = "neotest" },
		{ "<leader>u", group = "utils" },
		{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action" },
		{ "<leader>cr", vim.lsp.buf.rename, desc = "Rename Symbol" },
	},
})
