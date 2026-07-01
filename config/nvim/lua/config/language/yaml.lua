local M = {}

M.server_name = 'yamlls'

M.formatter = { 'prettierd', 'prettier' }

M.server_config = {
  settings = {
    yaml = {
      validate = true,
      completion = true,
      hover = true,
      schemastore = {
        enable = true,
      },
      schemas = {
        ['https://json.schemastore.org/github-workflow.json'] = {
          '.github/workflow/*.{yml,yaml}',
        },
      },
    },
    redhat = {
      telemetry = {
        enable = false,
      },
    },
  },
}

return M
