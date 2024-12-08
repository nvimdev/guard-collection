describe('stylua', function()
  it('can format', function()
    local ft = require('guard.filetype')
    ft('lua'):fmt('stylua')

    local formatted = require('test.formatter.helper').test_with('lua', {
      [[local M={}]],
      [[   M.foo  =]],
      [[  "foo"]],
      [[return        M]],
    })
    assert.are.same({
      [[local M = {}]],
      [[M.foo = 'foo']],
      [[return M]],
    }, formatted)
  end)
end)
