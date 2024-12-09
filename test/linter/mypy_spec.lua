describe('mypy', function()
  it('can lint', function()
    local helper = require('test.linter.helper')
    local ns = helper.namespace
    local ft = require('guard.filetype')
    ft('python'):lint('mypy')

    local diagnostics = helper.test_with('python', {
      [[def fib(n) -> Iterator[int]:]],
      [[  a, b = 0, 1]],
      [[  while a < n:]],
      [[    yield a]],
      [[    a, b = b, a+b]],
    })

    assert.are.same({}, diagnostics)
  end)
end)
