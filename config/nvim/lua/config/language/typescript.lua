local M = {}

M.server_name = "ts_ls"

M.server_config = {
  single_file_support = false,
  init_options = {
    hostInfo = "neovim",
  },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayFunctionLikeReturnTypeHints = true,
      },
    },
  },
}

M.formatter_name = "prettierd"

return M
