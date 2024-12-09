describe('pylint', function()
  it('can lint', function()
    local helper = require('test.linter.helper')
    local ns = helper.namespace
    local ft = require('guard.filetype')
    ft('python'):lint('pylint')

    local diagnostics = helper.test_with('python', {
      [[msg = "test"]],
      [[print msg]],
    })
    assert.are.same({}, diagnostics)
  end)
end)
