vim.env.PATH = table.concat({
  vim.fn.expand('~/.local/bin'),
  '/opt/homebrew/opt/rustup/bin',
  vim.fn.expand('~/.volta/bin'),
  '/opt/homebrew/bin',
  '/opt/homebrew/sbin',
  vim.env.PATH,
}, ':')

require('config.options')
require('config.keymaps')
require('config.autocmd')
require('config.lazy')
