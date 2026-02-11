return {
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        require("config.language.lua").server_name,
        require("config.language.lua").formatter_name,
      },
      automatic_enable = {
        exclude = {
          require("config.language.rust").server_name,
          require("config.language.rust").formatter_name,
        },
      },
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)

      -- rust LSP ON
      vim.lsp.enable(require("config.language.rust").server_name)
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
}
