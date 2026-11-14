-- Easily comment visual regions/lines
return {
  'numToStr/Comment.nvim',
  opts = {},
  config = function(_, opts)
    require('Comment').setup(opts)

    local map_opts = { noremap = true, silent = true }
    vim.keymap.set('n', '<C-_>', require('Comment.api').toggle.linewise.current, map_opts)
    vim.keymap.set('n', '<C-c>', require('Comment.api').toggle.linewise.current, map_opts)
    vim.keymap.set('n', '<C-/>', require('Comment.api').toggle.linewise.current, map_opts)
    vim.keymap.set('v', '<C-_>', "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", map_opts)
    vim.keymap.set('v', '<C-c>', "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", map_opts)
    vim.keymap.set('v', '<C-/>', "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", map_opts)
  end,
}
