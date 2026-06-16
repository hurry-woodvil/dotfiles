return {
  {
    "folke/lazydev.nvim",
    dependencies = {
      "DrKJeff16/wezterm-types",
    },
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "wezterm-types", words = { "wezterm" } },
      },
    },
  },
}
