local M = {}

M.opts = {
  adapters = {},
  configurations = {},
}

local function _set_adapters(mod)
  M.opts.adapters = vim.tbl_deep_extend("force", M.opts.adapters, mod.adapter or {})
end

local function _set_configurations(mod)
  M.opts.configurations = vim.tbl_deep_extend("force", M.opts.configurations, mod.configuration or {})
end

local function _setup()
  local path = vim.fn.stdpath("config") .. "/lua/plugins/debug/language"
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
