describe('pylint', function()
  it('can lint', function()
    local helper = require('test.linter.helper')
    local ns = helper.namespace
    local ft = require('guard.filetype')
    ft('python'):lint('pylint')
    require('guard').setup()

    local diagnostics = helper.test_with('python', {
      [[def foo(n):]],
      [[    if n in (1, 2, 3):]],
      [[        return n + 1]],
      [[a, b = 1, 2]],
      [[b, a = a, b]],
      [[print(f"The factorial of {a} is: {foo(a)}")]],
    })
    assert.are.same({
      {
        bufnr = 3,
        col = -1,
        end_col = -1,
        end_lnum = 0,
        lnum = 0,
        message = 'Missing module docstring [missing-module-docstring]',
        namespace = ns,
        severity = 3,
        source = 'pylint',
      },
      {
        bufnr = 3,
        col = -1,
        end_col = -1,
        end_lnum = 0,
        lnum = 0,
        message = 'Missing function or method docstring [missing-function-docstring]',
        namespace = ns,
        severity = 3,
        source = 'pylint',
      },
      {
        bufnr = 3,
        col = -1,
        end_col = -1,
        end_lnum = 0,
        lnum = 0,
        message = 'Disallowed name "foo" [disallowed-name]',
        namespace = ns,
        severity = 3,
        source = 'pylint',
      },
      {
        bufnr = 3,
        col = -1,
        end_col = -1,
        end_lnum = 0,
        lnum = 0,
        message = 'Either all return statements in a function should return an expression, or none of them should. [inconsistent-return-statements]',
        namespace = ns,
        severity = 3,
        source = 'pylint',
      },
    }, diagnostics)
  end)
end)
