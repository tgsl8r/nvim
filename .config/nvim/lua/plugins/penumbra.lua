return {

  -- penumbra options
  {
    "Allianaab2m/penumbra.nvim",
    name = "penumbra",
    config = function()
      require("penumbra").setup({
        light = true,
      })
    end,
  },
}
