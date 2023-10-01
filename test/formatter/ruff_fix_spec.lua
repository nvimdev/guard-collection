describe('ruff', function()
  it('can format', function()
    local ft = require('guard.filetype')
    ft('python'):fmt('ruff_fix')
    require('guard').setup()

    local formatted = require('test.formatter.helper').test_with('python', {
      [[import os]],
      [[]],
      [[def foo(n):]],
      [[  if n in (1, 2, 3):]],
      [[    return n + 1]],
      [[  a, b = 1, 2]],
    })
    assert.are.same({
      [[]],
      [[def foo(n):]],
      [[  if n in (1, 2, 3):]],
      [[    return n + 1]],
      [[  a, b = 1, 2]],
    }, formatted)
  end)
end)
