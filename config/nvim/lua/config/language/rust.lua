local M = {}

M.server_name = "rust_analyzer"

M.server_config = {}

M.formatter_name = "rustfmt"

M.adapter = {
  codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = vim.fn.stdpath("data") .. "../mason/packages/codelldb/extension/adapter/codelldb",
      args = { "--port", "${port}" },
    },
  },
}

M.configuration = {
  rust = {
    {
      name = "Debug executable",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      justMyCode = true,
    },
  },
}

return M
