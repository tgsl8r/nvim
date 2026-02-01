local bufferline_status, bufferline = pcall(require, "bufferline")
if not bufferline_status then
	print("Couldn't load bufferline")
	return
end

bufferline.setup({
	options = {
		diagnostics = "nvim_lsp",
		always_show_bufferline = false,
		offsets = {
			{
				filetype = "neo-tree",
				text = "Neo-tree",
				highlight = "Directory",
				text_align = "left",
			},
			{
				filetype = "snacks_layout_box",
			},
		},
	},
})
})
