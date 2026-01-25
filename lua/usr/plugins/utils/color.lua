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

bamboo.setup({
    -- Main options --
    style = 'vulgaris', -- Choose between 'vulgaris' (regular), 'multiplex' (greener), and 'light'
    toggle_style_key = nil, -- Keybind to toggle theme style. Leave it nil to disable it, or set it to a string, e.g. "<leader>ts"
    toggle_style_list = { 'vulgaris', 'multiplex', 'light' }, -- List of styles to toggle between
    transparent = false, -- Show/hide background
    dim_inactive = true, -- Dim inactive windows/buffers
    term_colors = true, -- Change terminal color as per the selected theme style
    ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
    cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

    -- Change code style ---
    -- Options are anything that can be passed to the `vim.api.nvim_set_hl` table
    -- You can also configure styles with a string, e.g. keywords = 'italic,bold'
    code_style = {
        comments = { italic = false },
        conditionals = { italic = false },
        keywords = {},
        functions = {},
        namespaces = { italic = false },
        parameters = { italic = false },
        strings = {},
        variables = {},
    },
    -- Custom Highlights --
    colors = {}, -- Override default colors
    highlights = {}, -- Override highlight groups

    -- Plugins Config --
    diagnostics = {
        darker = false, -- darker colors for diagnostic
        undercurl = true, -- use undercurl instead of underline for diagnostics
        background = true, -- use background color for virtual text
    },
})
