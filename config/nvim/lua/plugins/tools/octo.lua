return {
  {
    'pwntester/octo.nvim',
    cmd = 'Octo',
    opts = {
      picker = 'telescope',
      enable_builtin = true,
    },
    keys = {
      {
        '<leader>oi',
        '<cmd>Octo issue list<cr>',
        desc = 'List GitHub Issues',
      },
      {
        '<leader>op',
        '<cmd>Octo pr list<cr>',
        desc = 'List GitHub PullRequests',
      },
      {
        '<leader>od',
        '<cmd>Octo discussion list<cr>',
        desc = 'List GitHub Discussions',
      },
      {
        '<leader>on',
        '<cmd>Octo notification list<cr>',
        desc = 'List GitHub Notifications',
      },
      {
        '<leader>os',
        function()
          require('octo.utils').create_base_search_command({ incluede_current_repo = true })
        end,
        desc = 'Search GitHub',
      },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
}
