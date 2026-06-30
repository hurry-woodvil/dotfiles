local M = {}

function M.formatter(config)
  if type(config) == 'table' then
    local f = vim.deepcopy(config)

    if #f > 1 then
      f.stop_after_first = true
    end

    return f
  end
  return { config }
end

return M
