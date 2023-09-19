local M = {}
local api = vim.api
require('guard.lint')
M.namespace = api.nvim_get_namespaces().Guard

function M.test_with(ft, input)
  local bufnr = api.nvim_create_buf(true, false)
  vim.bo[bufnr].filetype = ft
  api.nvim_set_current_buf(bufnr)
  api.nvim_buf_set_lines(bufnr, 0, -1, false, input)
  -- To make linters happy
  vim.cmd('silent! write! /tmp/test.' .. ft)
  require('guard.lint').do_lint(bufnr)
  vim.wait(5000)
  return vim.diagnostic.get(bufnr)
end

return M
