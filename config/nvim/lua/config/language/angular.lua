local M = {}

local fs, fn, uv = vim.fs, vim.fn, vim.uv

local function get_angular_core_version(root_dir)
  local package_json = fs.joinpath(root_dir, 'package.json')
  if not uv.fs_stat(package_json) then
    return ''
  end

  local ok, content = pcall(fn.readblob, package_json)
  if not ok or not content then
    return ''
  end

  local json = vim.json.decode(content) or {}

  local version = (json.dependencies or {})['@angular/core'] or (json.devDependencies or {})['@angular/core'] or ''
  return version:match('%d+%.%d+%.%d+') or ''
end

M.server_name = 'angularls'

---@type vim.lsp.Config
M.server_config = {
  cmd = function(dispatchers, config)
    local root_dir = (config and config.root_dir) or fn.getcwd()
    local node_modules = fs.joinpath(root_dir, 'node_modules')
    local ngserver = fs.joinpath(node_modules, '.bin', 'ngserver')

    local cmd = {
      ngserver,
      '--stdio',
      '--tsProbeLocations',
      node_modules,
      '--ngProbeLocations',
      node_modules,
      '--angularCoreVersion',
      get_angular_core_version(root_dir),
    }
    return vim.lsp.rpc.start(cmd, dispatchers)
  end,
}

M.formatter = { 'prettierd', 'prettier' }

return M
