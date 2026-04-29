return {
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
      "b0o/schemastore.nvim",
    },
    opts = {
      ensure_installed = {
        require("config.language.lua").server_name,
        require("config.language.toml").server_name,
        require("config.language.typescript").server_name,
        require("config.language.javascript").server_name,
        require("config.language.json").server_name,
        require("config.language.html").server_name,
        require("config.language.css").server_name,
        require("config.language.emmet").server_name,
        require("config.language.tailwindcss").server_name,
      },
      automatic_enable = {
        exclude = {
          require("config.language.rust").server_name,
          require("config.language.rust").formatter_name,
        },
      },
    },
    ---@param opts MasonLspconfigSettings
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)

      -- diagnostic config
      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
      })

      -- rust LSP ON
      vim.lsp.enable(require("config.language.rust").server_name)
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "mason-org/mason.nvim",
    },
    opts = {
      ensure_installed = {
        require("config.language.lua").formatter_name,
        require("config.language.typescript").formatter_name,
        require("config.language.javascript").formatter_name,
        require("config.language.html").formatter_name,
        require("config.language.css").formatter_name,
        require("config.language.eslint").server_name,
      },
    },
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
