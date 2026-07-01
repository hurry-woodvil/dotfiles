local formatter = require('utils').formatter

return {
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        lua = formatter(require('config.language.lua').formatter),
        rust = formatter(require('config.language.rust').formatter),
        toml = formatter(require('config.language.toml').formatter),
        typescript = formatter(require('config.language.typescript').formatter),
        typescriptreact = formatter(require('config.language.typescript').formatter),
        javascript = formatter(require('config.language.javascript').formatter),
        javascriptreact = formatter(require('config.language.javascript').formatter),
        html = formatter(require('config.language.html').formatter),
        css = formatter(require('config.language.css').formatter),
        scss = formatter(require('config.language.css').formatter),
        json = formatter(require('config.language.json').formatter),
        jsonc = formatter(require('config.language.json').formatter),
        python = formatter(require('config.language.python').formatter),
        htmlangular = formatter(require('config.language.angular').formatter),
        yaml = formatter(require('config.language.yaml').formatter),
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = 'fallback',
      },
    },
  },
}
