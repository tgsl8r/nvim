-- Colorscheme options
-- vim.g.gruvbox_material_background = "soft"
vim.g.gruvbox_flat_style = "dark"
vim.g.gruvbox_italic_comments = false
vim.g.gruvbox_italic_keywords = false

-- Set colourscheme
local colorscheme = "gruvbox-flat"
local colorscheme_status, _ = pcall(vim.cmd.colorscheme, colorscheme)
if not colorscheme_status then
	print("Colorscheme " .. colorscheme .. " not found!")
	return
end


