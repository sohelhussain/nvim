-- Custom code snippets and diagnostic styling

-- Prevent LSP from overwriting treesitter color settings
-- https://github.com/NvChad/NvChad/issues/1907
if vim.hl and vim.hl.priorities then
  vim.hl.priorities.semantic_tokens = 95
elseif vim.highlight and vim.highlight.priorities then
  vim.highlight.priorities.semantic_tokens = 95
end

-- Appearance of diagnostics
vim.diagnostic.config {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.INFO] = ' ',
      [vim.diagnostic.severity.HINT] = '󰌵',
    },
  },
  virtual_text = {
    prefix = '●',
    format = function(diagnostic)
      local code = diagnostic.code and string.format('[%s]', diagnostic.code) or ''
      return string.format('%s %s', code, diagnostic.message)
    end,
  },
  underline = false,
  update_in_insert = true,
  float = {
    source = 'always',
    border = 'rounded',
  },
}

-- Make diagnostic background transparent on colorscheme load
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    pcall(vim.cmd, 'highlight DiagnosticVirtualText guibg=NONE')
  end,
})

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    if vim.hl and vim.hl.on_yank then
      vim.hl.on_yank()
    else
      vim.highlight.on_yank()
    end
  end,
  group = highlight_group,
  pattern = '*',
})
