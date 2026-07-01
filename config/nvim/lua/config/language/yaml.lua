local M = {}

M.server_name = 'yamlls'

M.formatter = { 'prettierd', 'prettier' }

M.server_config = {
  settings = {
    yaml = {
      validate = true,
      completion = true,
      hover = true,
      schemaStore = {
        enable = true,
      },
      schemas = {
        ['https://json.schemastore.org/github-workflow.json'] = {
          '.github/workflows/*.{yml,yaml}',
        },
      },
    },
    redhat = {
      telemetry = {
        enabled = false,
      },
    },
  },
}

return M
