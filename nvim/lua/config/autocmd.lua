vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if not client then
      return
    end

    local keymaps = require("config.keymaps")
    keymaps.reset(bufnr)
    keymaps.on_attach(client, bufnr)
  end,
})

local orig_register = vim.lsp.handlers["client/registerCapability"]

vim.lsp.handlers["client/registerCapability"] = function(err, result, ctx, config)
  local client = vim.lsp.get_client_by_id(ctx.client_id)

  local ret = orig_register(err, result, ctx, config)

  if client then
    for bufnr in pairs(client.attached_buffers) do
      require("config.keymaps").on_attach(client, bufnr)
    end
  end

  return ret
end
