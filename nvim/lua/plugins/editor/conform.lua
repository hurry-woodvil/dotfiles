return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { require("config.language.lua").formatter_name },
        rust = { require("config.language.rust").formatter_name },
        toml = { require("config.language.toml").server_name },
        typescript = { require("config.language.typescript").formatter_name },
        typescriptreact = { require("config.language.typescript").formatter_name },
        javascript = { require("config.language.javascript").formatter_name },
        javascriptreact = { require("config.language.javascript").formatter_name },
        html = { require("config.language.html").formatter_name },
        css = { require("config.language.css").formatter_name },
        scss = { require("config.language.css").formatter_name },
        json = { require("config.language.json").formatter_name },
        jsonc = { require("config.language.json").formatter_name },
        go = require("config.language.golang").formatter_name,
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    },
  },
}
