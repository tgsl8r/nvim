-- plugins.lua
-- Install and import the config of plugins

vim.pack.add({
  -- UI
	{ src = "git@github.com:eddyekofo94/gruvbox-flat.nvim" },
	{ src = "git@github.com:folke/snacks.nvim" },
	{ src = "git@github.com:folke/which-key.nvim" },
  -- Treesitter
	{ src = "git@github.com:nvim-treesitter/nvim-treesitter.git" },
	{ src = "git@github.com:nvim-treesitter/nvim-treesitter-textobjects.git" },
  -- Code
	{ src = "git@github.com:lewis6991/gitsigns.nvim.git" },
})

-- Utils
require("usr.plugins.utils")
-- Language tools
require("usr.plugins.code")
