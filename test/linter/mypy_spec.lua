describe('mypy', function()
  it('can lint', function()
    local helper = require('test.linter.helper')
    local ns = helper.namespace
    local ft = require('guard.filetype')
    ft('python'):lint('mypy')

    local diagnostics = helper.test_with('python', {
      [[from typing import Iterator]],
      [[def fib(n) -> Iterator[str]:]],
      [[  a, b = 0, 1]],
      [[  while a < n:]],
      [[    yield a]],
      [[    a, b = b, a+b]],
    })

    assert.are.same({
      {
        bufnr = 3,
        col = 4,
        end_col = 10,
        end_lnum = 4,
        lnum = 4,
        message = 'Incompatible types in "yield" (actual type "int", expected type "str") [misc]',
        namespace = 2,
        severity = 1,
        source = 'mypy',
      },
    }, diagnostics)
  end)
end)
