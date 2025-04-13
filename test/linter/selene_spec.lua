describe('selene', function()
  it('can lint', function()
    local helper = require('test.linter.helper')
    local ns = helper.namespace
    local ft = require('guard.filetype')
    ft('lua'):lint('selene')

    local buf, diagnostics = helper.test_with('lua', {
      [[print(a)]],
    })
    assert.are.same({
      {
        bufnr = buf,
        col = 6,
        end_col = 0,
        end_lnum = 0,
        lnum = 0,
        message = '`a` is not defined[undefined_variable]',
        namespace = ns,
        severity = 1,
        source = 'selene',
      },
    }, diagnostics)
  end)
end)
