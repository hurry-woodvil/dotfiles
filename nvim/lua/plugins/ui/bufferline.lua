return {
  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        numbers = "ordinal",
        separator_style = "slant",
        hover = {
          enabled = true,
          delay = 100,
          reveal = { "close" }
        },
      }
    },
    config = function(_, opts)
      opts = vim.tbl_extend("force", opts, {
        highlights = require("catppuccin.special.bufferline").get_theme(),
      })
      require("bufferline").setup(opts)
    end,
  },
}
