-- Configure Gruvbox-flat
-- vim.g.gruvbox_material_background = "soft"
vim.g.gruvbox_flat_style = "dark"
vim.g.gruvbox_italic_comments = false
vim.g.gruvbox_italic_keywords = false

-- Load and configure Bamboo
local bamboo_status, bamboo = pcall(require, "bamboo")
if not bamboo_status then
	print("Couldn't load bamboo")
	return
end


