describe('selene', function()
  it('can lint', function()
    local helper = require('test.linter.helper')
    local ns = helper.namespace
    local ft = require('guard.filetype')
    ft('lua'):lint('selene')

    local diagnostics = helper.test_with('lua', {
      [[a = b]],
      [[b = a]],
    })
    assert.are.same({}, diagnostics)
  end)
end)
