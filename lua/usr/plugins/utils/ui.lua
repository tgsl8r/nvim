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

	local symbols = {
		added = " ",
		changed = " ",
		removed = " ",
	}

	local colors = {
		added = "%#GitSignsAdd#",
		changed = "%#GitSignsChange#",
		removed = "%#GitSignsDelete#",
		reset = "%#StatusLine#",
	}

	local added_str = git_info.added and (colors.added .. symbols.added .. git_info.added .. colors.reset) or ""
	local changed_str = git_info.changed and (colors.changed .. symbols.changed .. git_info.changed .. colors.reset)
		or ""
	local removed_str = git_info.removed and (colors.removed .. symbols.removed .. git_info.removed .. colors.reset)
		or ""

	return table.concat({
		"%#StatusLine#",
		" ",
		head,
		" ",
		added_str,
		" ",
		changed_str,
		" ",
		removed_str,
	})
end

local function path()
	local bufname = vim.api.nvim_buf_get_name(0)
	if bufname == "" then
		return ""
	end

	local git_status = vim.b.gitsigns_status_dict
	local git_root = git_status and git_status.root
	if git_root and bufname:sub(1, #git_root) == git_root then
		local repo_name = vim.fn.fnamemodify(git_root, ":t")
		local rel_path = bufname:sub(#git_root + 2)
		return repo_name .. "/" .. rel_path
	end

	return vim.fn.fnamemodify(bufname, ":~")
end

Statusline = {}

function Statusline.active()
	return table.concat({
		"[ ",
		path(),
		" ][ ",
		git(),
		" ]",
		"%=",
		"%y [%P %l:%c]",
	})
end

function Statusline.inactive()
	return " %t"
end

local group = vim.api.nvim_create_augroup("StatusLine", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	group = group,
	desc = "Activate statusline on focus",
	callback = function()
		vim.opt_local.statusline = "%!v:lua.Statusline.active()"
	end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	group = group,
	desc = "Deactivate statusline when unfocused",
	callback = function()
		vim.opt_local.statusline = "%!v:lua.Statusline.inactive()"
	end,
})
