return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      require("rainbow-delimiters.setup").setup()
      vim.g.rainbow_delimiters = {
        highlight = {
          "RainbowDelimiterBlue",
          "RainbowDelimiterCyan",
          "RainbowDelimiterGreen",
          "RainbowDelimiterOrange",
          "RainbowDelimiterViolet",
          "RainbowDelimiterYellow",
        },
      }
    end,
  },
}
