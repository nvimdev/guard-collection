describe('ruff', function()
  it('can lint', function()
    local helper = require('test.linter.helper')
    local ns = helper.namespace
    local ft = require('guard.filetype')
    ft('python'):lint('ruff')

    local diagnostics = helper.test_with('python', {
      [[import os]],
      [[print("foo")]],
    })
    assert.are.same({}, diagnostics)
  end)
end)
