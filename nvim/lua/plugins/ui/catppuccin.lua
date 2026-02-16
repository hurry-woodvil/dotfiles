return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        integrations = {
          barbar = true,
          mason = true,
          noice = true,
          dap = true,
          dap_ui = true,
          snacks = {
            enabled = true,
          },
          lsp_trouble = true,
          which_key = true,
        },
      })
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
}
