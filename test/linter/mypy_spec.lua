describe('mypy', function()
  it('can lint', function()
    local helper = require('test.linter.helper')
    local ns = helper.namespace
    local ft = require('guard.filetype')
    ft('python'):lint('mypy')

    local diagnostics = helper.test_with('python', {
      [[def foo() -> str:]],
      [[    return 42]],
    })

    assert.are.same({
      {
        bufnr = 3,
        col = 11,
        end_col = 12,
        end_lnum = 1,
        lnum = 1,
        message = 'Incompatible return value type (got "int", expected "str") [return-value]',
        namespace = ns,
        severity = 1,
        source = 'mypy',
      },
    }, diagnostics)
  end)
end)
