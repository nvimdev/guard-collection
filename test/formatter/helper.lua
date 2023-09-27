local M = {}
local api = vim.api

function M.test_with(ft, input)
  local bufnr = api.nvim_create_buf(true, false)
  vim.bo[bufnr].filetype = ft
  api.nvim_set_current_buf(bufnr)
  api.nvim_buf_set_lines(bufnr, 0, -1, false, input)
  -- To provide fname
  vim.cmd('silent! write! /tmp/file.' .. ft)
  require('guard.format').do_fmt(bufnr)
  vim.wait(5000)
  return api.nvim_buf_get_lines(bufnr, 0, -1, false)
end

return M
