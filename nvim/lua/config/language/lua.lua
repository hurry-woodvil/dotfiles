local M = {}

M.server_name = "lua_ls"

M.server_config = {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME .. "/lua",
        },
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
      doc = {
        privateName = { "^_" },
      },
    },
  },
}

M.formatter_name = "stylua"

return M
