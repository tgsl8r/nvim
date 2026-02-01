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

-- status line helpers

local function git()
	local git_info = vim.b.gitsigns_status_dict
	if not git_info or git_info.head == "" then
		return ""
	end

	local head = git_info.head
	local added = git_info.added and (" +" .. git_info.added) or ""
	local changed = git_info.changed and (" ~" .. git_info.changed) or ""
	local removed = git_info.removed and (" -" .. git_info.removed) or ""

	return table.concat({
		" ",
		head,
		added,
		changed,
		removed,
	})
end
})
