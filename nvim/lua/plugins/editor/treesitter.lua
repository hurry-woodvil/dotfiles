return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "lua", "vim", "rust" },
      indent = { enable = true },
      highlight = {
        enable = true
      }
    }
  }
}
