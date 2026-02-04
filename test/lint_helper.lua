local M = {}
local api = vim.api
local lint = require('guard.lint')
M.namespace = api.nvim_get_namespaces().Guard

function M.test_with(ft, input)
  local linter = require('guard.filetype')(ft).linter[1]
  local cmd = linter.cmd
  if cmd then
    assert(vim.fn.executable(cmd) == 1)
  end

  local bufnr = api.nvim_create_buf(true, false)
  vim.bo[bufnr].filetype = ft
  api.nvim_set_current_buf(bufnr)
  api.nvim_buf_set_lines(bufnr, 0, -1, false, input)
  -- To make linters happy (use project dir, not /tmp, for tools like buf that scan parents)
  vim.cmd('silent! write! test/test.' .. ft)

  lint.do_lint(bufnr)
  vim.wait(3000)
  local diagnostics = vim.diagnostic.get(bufnr)
  for _, d in ipairs(diagnostics) do
    d._extmark_id = nil
  end
  return bufnr, diagnostics
end

function M.assert_diagnostics(actual, expected)
  assert(
    #expected == #actual,
    'Diagnostic count mismatch: expected ' .. #expected .. ', got ' .. #actual
  )
  for _, exp in ipairs(expected) do
    local found = false
    for _, act in ipairs(actual) do
      if vim.deep_equal(exp, act) then
        found = true
        break
      end
    end
    assert(found, 'Expected diagnostic not found: ' .. vim.inspect(exp))
  end
end

return M
