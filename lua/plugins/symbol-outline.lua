return {
  "simrat39/symbols-outline.nvim",
  config = function()
    require("symbols-outline").setup({})
  end,
  keys = {
    {
      "<leader>cs",
      "<cmd>SymbolsOutline<cr>",
      desc = "Show symbol outline",
    },
  },
}
