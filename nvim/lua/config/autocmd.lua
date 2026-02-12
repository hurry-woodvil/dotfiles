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
