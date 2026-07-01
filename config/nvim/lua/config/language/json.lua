local M = {}

M.server_name = 'jsonls'

M.server_config = function()
  local schemastore = require('schemastore')
  return {
    settings = {
      json = {
        schemas = schemastore.json.schemas(),
        validate = { enable = true },
        format = { enable = true },
      },
    },
  }
end

M.formatter = { 'prettierd', 'prettier' }

return M
