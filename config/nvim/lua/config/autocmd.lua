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

local function refresh_oil_all_windows()
  local ok, oil_git_status = pcall(require, "oil-git-status")
  if not ok then
    return
  end

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local bufnr = vim.api.nvim_win_get_buf(win)
    if vim.bo[bufnr].filetype == "oil" then
      vim.api.nvim_buf_call(bufnr, function()
        oil_git_status.refresh_buffer(bufnr)
      end)
    end
  end
end

vim.api.nvim_create_autocmd("TermClose", {
  group = vim.api.nvim_create_augroup("RefreshOilAfterLazyGit", { clear = true }),
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    local name = vim.api.nvim_buf_get_name(args.buf)

    if ft == "lazygit" or name:lower():find("lazygit") then
      vim.schedule(refresh_oil_all_windows)
    end
  end,
})
