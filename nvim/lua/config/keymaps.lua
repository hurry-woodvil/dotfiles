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

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    vim.bo[bufnr].omnifunc = nil
    vim.bo[bufnr].tagfunc = nil
    vim.bo[bufnr].formatexpr = nil
  end,
})
