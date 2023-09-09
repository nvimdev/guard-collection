describe('yapf', function()
  it('can format', function()
    local ft = require('guard.filetype')
    ft('python'):fmt('yapf')
    require('guard').setup()

    local formatted = require('test.formatter.helper').test_with('python', {
      [[def foo(n):]],
      [[    if n in         (1,2,3):]],
      [[        return n+1]],
      [[a, b = 1,    2]],
      [[b, a =     a, b]],
      [[print(  f"The factorial of {a} is: {foo(a)}")]],
    })
    assert.are.same({
      [[def foo(n):]],
      [[    if n in (1, 2, 3):]],
      [[        return n + 1]],
      [[]],
      [[]],
      [[a, b = 1, 2]],
      [[b, a = a, b]],
      [[print(f"The factorial of {a} is: {foo(a)}")]],
    }, formatted)
  end)
end)
