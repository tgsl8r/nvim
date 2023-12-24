return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    require("tokyonight").setup({
      light_style = "day", -- The theme is used when the background is set to light
    }),
  },
}
