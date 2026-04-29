return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "lua",
        "vim",
        "rust",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
      },
      indent = { enable = true },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    },
    config = function()
      local ts = require("nvim-treesitter")

      ts.setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      ts.install({
        "lua",
        "vim",
        "rust",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
      }):wait(30000)

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter-indent", { clear = true }),
        pattern = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
        },
        callback = function()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
