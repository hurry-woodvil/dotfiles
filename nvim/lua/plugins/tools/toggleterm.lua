return {
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      { "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal (float)" },
      { "<leader>th", "<cmd>ToggleTerm size=15 direction=horizontal<cr>", desc = "Terminal (horizontal)" },
      { "<leader>tv", "<cmd>ToggleTerm size=60 direction=vertical<cr>", desc = "Terminal (vertical)" },
    },
    opts = {
      size = 20,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      persist_mode = true,
      direction = "float",
      float_opts = {
        border = "rounded",
        width = function()
          return math.floor(vim.o.columns * 0.9)
        end,
        hight = function()
          return math.floor(vim.o.lines * 0.85)
        end,
      },
      close_on_exit = true,
      shell = vim.o.shell,
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Terminal normal mode" })
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { desc = "Move left" })
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { desc = "Move down" })
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { desc = "Move up" })
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { desc = "Move right" })

      local Terminal = require("toggleterm.terminal").Terminal

      local node = Terminal:new({
        cmd = "node",
        hidden = true,
        direction = "float",
      })

      vim.keymap.set("n", "<leader>tn", function()
        node:toggle()
      end, { desc = "Node REPL" })

      local cargo = Terminal:new({
        cmd = "cargo run",
        hidden = true,
        direction = "float",
      })

      vim.keymap.set("n", "<leader>tr", function()
        cargo:toggle()
      end, { desc = "Cargo run" })
    end,
  },
}
