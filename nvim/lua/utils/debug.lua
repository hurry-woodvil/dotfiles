local M = {}

M.opts = {
  adapters = {},
  configurattions = {},
}

local function _set_adapters(mod)
  M.opts.adapters = vim.tbl_deep_extend("force", M.opts.adapters, mod.adapters or {})
end

local function _set_configurations(mod)
  M.opts.configurattions = vim.tbl_deep_extend("force", M.opts.configurattions, mod.configurattions or {})
end

local function _setup()
  local path = vim.fn.stdpath("config") .. "/lua/config/language"
  local files = vim.fn.glob(path .. "/*.lua", true, true)

  for _, file in ipairs(files) do
    local module = file:gsub(vim.fn.stdpath("config") .. "/lua/", ""):gsub("%.lua$", ""):gsub("/", ".")

    local mod = require(module)
    _set_adapters(mod)
    _set_configurations(mod)
  end
end

function M.get_opts()
  _setup()
  return M.opts
end

return M
