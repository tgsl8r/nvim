return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },

    opts = {
      servers = {
        clangd = {
          mason = false,
        },
      },
    },

    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ruff", "rust-analyzer", "cpptools", "codelldb", "biome" }, -- Add as needed
      })

      require("mason-lspconfig").setup_handlers({
        function(server)
          require("lspconfig")[server].setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            on_attach = function(client, bufnr)
              -- inlay hints
              if client.server_capabilities.inlayHintProvider then
                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
              end
            end,
          })
        end,
      })
    end
  },
}
