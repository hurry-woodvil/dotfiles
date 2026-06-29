local M = {}

M.server_name = 'basedpyright'

M.server_config = {
  settings = {
    python = {
      pythonPath = '.venv/bin/python',
      venvPath = '.',
      venv = '.venv',
      analysis = {
        typeCheckingMode = 'basic',
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
}

M.formatter_name = 'ruff'

M.confirm_formatter_name = 'ruff_format'

M.adapter = {
  python = {
    type = 'executable',
    command = vim.fn.stdpath('data') .. '/mason/packages/debugpy/venv/bin/python',
    args = {
      '-m',
      'debugpy.adapter',
    },
  },
}

M.configuration = {
  python = {
    {
      name = 'Debug current file',
      type = 'python',
      request = 'launch',
      program = '${file}',
      console = 'integratedTerminal',
      args = function()
        local input = vim.fn.input('Arguments: ')
        return vim.split(input, ' ')
      end,
      justMyCode = true,
    },
    {
      name = 'Debug executable/module',
      type = 'python',
      request = 'launch',
      module = function()
        return vim.fn.input('Python module: ')
      end,
      console = 'integratedTerminal',
      justMyCode = true,
    },
  },
}

return M
