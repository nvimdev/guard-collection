describe('ruff', function()
  it('can lint', function()
    local helper = require('test.linter.helper')
    local ns = helper.namespace
    local ft = require('guard.filetype')
    ft('python'):lint('ruff')
    require('guard').setup()

    local diagnostics = helper.test_with('python', {
      [[import os]],
      [[def foo(n):]],
      [[  if n in (1, 2, 3):]],
      [[    return n + 1]],
      [[  a, b = 1, 2]],
    })
    assert.are.same(
      {
        {
          bufnr = 1,
          col = 7,
          end_col = 7,
          end_lnum = 0,
          lnum = 0,
          message = '`os` imported but unused [F401]',
          namespace = 5,
          severity = 1,
          source = 'ruff',
        },
        {
          bufnr = 1,
          col = 4,
          end_col = 4,
          end_lnum = 6,
          lnum = 6,
          message = 'Local variable `a` is assigned to but never used [F841]',
          namespace = 5,
          severity = 1,
          source = 'ruff',
        },
        {
          bufnr = 1,
          col = 7,
          end_col = 7,
          end_lnum = 6,
          lnum = 6,
          message = 'Local variable `b` is assigned to but never used [F841]',
          namespace = 5,
          severity = 1,
          source = 'ruff',
        },
      },
      diagnostics
    )
  end)
end)
