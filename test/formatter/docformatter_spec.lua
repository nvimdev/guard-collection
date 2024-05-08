describe('docformatter', function()
  it('can format', function()
    local ft = require('guard.filetype')
    ft('python'):fmt('docformatter')
    require('guard').setup()

    local formatted = require('test.formatter.helper').test_with('python', {
      [[def foo():]],
      [[    """]],
      [[    Hello foo.]],
      [[    """]],
      [[    if True:]],
      [[        x = 1]],
    })
    assert.are.same({
      [[def foo():]],
      [[    """Hello foo."""]],
      [[    if True:]],
      [[        x = 1]],
    }, formatted)
  end)
end)
