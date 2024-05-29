describe('selene', function()
  it('can lint', function()
    local helper = require('test.linter.helper')
    local ns = helper.namespace
    local ft = require('guard.filetype')
    ft('lua'):lint('selene')
    require('guard').setup()

    local diagnostics = helper.test_with('lua', {
      [[local M = {}]],
      [[function M.foo()]],
      [[  print("foo")]],
      [[end]],
      [[U.bar()]],
      [[return M]],
    })
    assert.are.same({
      {
        bufnr = 3,
        col = 0,
        end_col = 0,
        end_lnum = 4,
        lnum = 4,
        message = '`U` is not defined[undefined_variable]',
        namespace = ns,
        severity = 1,
        source = 'selene',
      },
    }, diagnostics)
  end)
end)
