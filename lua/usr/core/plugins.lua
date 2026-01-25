-- plugins.lua
-- Install and import the config of plugins

vim.pack.add({
  -- deps
    { src = "git@github.com:nvim-lua/plenary.nvim.git" },
    { src = "git@github.com:nvim-tree/nvim-web-devicons" },
  -- UI
	{ src = "git@github.com:folke/snacks.nvim" },
	{ src = "git@github.com:folke/which-key.nvim" },
	{ src = "git@github.com:folke/trouble.nvim" },
	{ src = "git@github.com:folke/todo-comments.nvim" },
	{ src = "git@github.com:akinsho/bufferline.nvim" },
  -- Colourschemes
	{ src = "git@github.com:eddyekofo94/gruvbox-flat.nvim" },
	{ src = "git@github.com:ribru17/bamboo.nvim" },
  -- Treesitter
	{ src = "git@github.com:nvim-treesitter/nvim-treesitter.git" },
	{ src = "git@github.com:nvim-treesitter/nvim-treesitter-textobjects.git" },
	{ src = "git@github.com:nvim-treesitter/nvim-treesitter-context.git" },
  -- Code
	{ src = "git@github.com:lewis6991/gitsigns.nvim.git" },
})

-- Utils
require("usr.plugins.utils")
-- Language tools
require("usr.plugins.code")
