local function safe_del(modes, lhs)
  pcall(vim.keymap.del, modes, lhs)
end

-- Remove Neovim's default global LSP keymaps (Neovim 0.11+)
safe_del({ "n", "x" }, "gra")
safe_del("n", "gri")
safe_del("n", "grn")
safe_del("n", "grr")
safe_del("n", "grt")
safe_del("n", "gO")
safe_del("i", "<C-S>")
safe_del({ "x", "o" }, "an")
safe_del({ "x", "o" }, "in")

local M = {}

--- @param bufnr integer
function M.reset(bufnr)
  vim.bo[bufnr].omnifunc = nil
  vim.bo[bufnr].tagfunc = nil
  vim.bo[bufnr].formatexpr = nil
end

--- @param client vim.lsp.Client
--- @param bufnr integer
function M.on_attach(client, bufnr)
  --- @param mode string|string[]
  --- @param lhs string
  --- @param rhs string|function
  --- @param desc string
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
  end

  if client:supports_method("textDocument/definition") then
    map("n", "gd", vim.lsp.buf.definition, "LSP: Go to Definition")
  end

  if client:supports_method("textDocument/declaration") then
    map("n", "gD", vim.lsp.buf.declaration, "LSP: Go to Declaration")
  end

  if client:supports_method("textDocument/typeDefinition") then
    map("n", "gy", vim.lsp.buf.type_definition, "LSP: Go to Type Definition")
  end

  if client:supports_method("textDocument/implementation") then
    map("n", "gI", vim.lsp.buf.implementation, "LSP: Go to Implementation")
  end

  if client:supports_method("textDocument/references") then
    map("n", "gr", vim.lsp.buf.references, "LSP: References")
  end

  if client:supports_method("textDocument/documentSymbol") then
    map("n", "<leader>cs", vim.lsp.buf.document_symbol, "LSP: Document Symbols")
  end

  if client:supports_method("textDocument/hover") then
    map("n", "K", vim.lsp.buf.hover, "LSP: Hover")
  end

  if client:supports_method("textDocument/signatureHelp") then
    map({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, "LSP: Signature Help")
  end

  if client:supports_method("textDocument/rename") then
    map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: Rename")
  end

  if client:supports_method("textDocument/codeAction") then
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "LSP: Code Action")
  end

  if client:supports_method("textDocument/documentHighlight") then
    local grp = vim.api.nvim_create_augroup("UserLspDocumentHighlight", { clear = false })
    vim.api.nvim_clear_autocmds({ group = grp, buffer = bufnr })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = grp,
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      group = grp,
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end

  if client:supports_method("textDocument/inlayHint") and vim.lsp.inlay_hint then
    map("n", "<leader>uh", function()
      local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
      vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
    end, "LSP: Toggle Inlay Hints")
  end
end

return M
