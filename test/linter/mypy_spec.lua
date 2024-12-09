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

    assert.are.same({}, diagnostics)
  end)
end)
