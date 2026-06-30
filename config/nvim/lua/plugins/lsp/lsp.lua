return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'b0o/schemastore.nvim',
    },
    config = function()
      local lsp = vim.lsp

      -- html LSP ON
      lsp.enable(require('config.language.html').server_name)

      -- css LSP ON
      lsp.enable(require('config.language.css').server_name)

      -- tailwindcss LSP ON
      lsp.enable(require('config.language.tailwindcss').server_name)

      -- emmet LSP ON
      lsp.enable(require('config.language.emmet').server_name)

      -- json LSP ON
      lsp.enable(require('config.language.json').server_name)

      -- yaml LSP ON
      lsp.enable(require('config.language.yaml').server_name)

      -- toml LSP ON
      lsp.enable(require('config.language.toml').server_name)

      -- lua LSP ON
      lsp.enable(require('config.language.lua').server_name)

      -- typescript LSP ON
      lsp.enable(require('config.language.typescript').server_name)

      -- angular LSP ON
      lsp.enable(require('config.language.angular').server_name)

      -- rust LSP ON
      lsp.enable(require('config.language.rust').server_name)

      -- python LSP ON
      lsp.enable(require('config.language.python').server_name)

      -- eslint_d LSP ON
      lsp.enable(require('config.language.emmet').server_name)

      -- prettierd LSP ON
      lsp.enable(require('config.language.prettierd').server_name)

      -- diagnostic config
      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = 'if_many',
          prefix = '●',
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = ' ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.HINT] = ' ',
            [vim.diagnostic.severity.INFO] = ' ',
          },
        },
      })
    end,
  },
}
