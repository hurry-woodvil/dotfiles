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

local keymap = vim.keymap

-- better up/down
keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keymap.set({ "n", "x" }, "<down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
keymap.set({ "n", "x" }, "<up>", "v:count == 0 ? 'gj' : 'j'", { desc = "Up", expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
keymap.set("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
keymap.set("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
keymap.set("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
keymap.set("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

keymap.set("n", "<esc><esc>", "<cmd>nohlsearch<cr>", { desc = "Clear Highlight Search" })

keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

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
