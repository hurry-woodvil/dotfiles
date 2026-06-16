local M = {}

function M.apply(config)
  config.default_prog = { "zsh", "-lc", "tmux new-session -A -s main" }
end

return M
