local trouble_status, trouble = pcall(require, "trouble")
if not trouble_status then
	print("Couldn't load trouble")
	return
end

trouble.setup({
    opts = {
        modes = {
            lsp = {
                win = { position = "right" },
            },
        },
    },
})
