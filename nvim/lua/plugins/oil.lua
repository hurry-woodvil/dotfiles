return {
  {
    "stevearc/oil.nvim",
    dependencies = {
      "nvim-mini/mini.icons",
    },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
      {
        "<leader>e",
        function()
          require("oil").open(vim.fn.expand("%:p:h"))
        end,
        desc = "Open Oil at current file",
      },
    },
    opts = {
      columns = {
        { "icon" },
        { "size" },
        { "mtime" },
      },
    },
  },
}
