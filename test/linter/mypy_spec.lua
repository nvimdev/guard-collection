describe('mypy', function()
  it('can lint', function()
    local helper = require('test.linter.helper')
    local ns = helper.namespace
    local ft = require('guard.filetype')
    ft('python'):lint('mypy')
    require('guard').setup()

    local diagnostics = helper.test_with('python', {
      [[def f(i: int) -> int:]],
      [[    i += "123"]],
      [[    return i]],
      [[sum()]],
    })
    assert.are.same({
      {
        bufnr = 3,
        col = 9,
        end_col = 13,
        end_lnum = 1,
        lnum = 1,
        message = 'Unsupported operand types for + ("int" and "str") [operator]',
        namespace = 33,
        severity = 1,
        source = 'mypy',
      },
      {
        bufnr = 3,
        col = 0,
        end_col = 4,
        end_lnum = 3,
        lnum = 3,
        message = 'All overload variants of "sum" require at least one argument [call-overload]',
        namespace = 33,
        severity = 1,
        source = 'mypy',
      },
      {
        bufnr = 3,
        col = 0,
        end_col = 4,
        end_lnum = 3,
        lnum = 3,
        message = 'Possible overload variants: []',
        namespace = 33,
        severity = 3,
        source = 'mypy',
      },
      {
        bufnr = 3,
        col = 0,
        end_col = 4,
        end_lnum = 3,
        lnum = 3,
        message = '    def sum(Iterable[bool], /, start: int = ...) -> int []',
        namespace = 33,
        severity = 3,
        source = 'mypy',
      },
      {
        bufnr = 3,
        col = 0,
        end_col = 4,
        end_lnum = 3,
        lnum = 3,
        message = '    def [_SupportsSumNoDefaultT <: _SupportsSumWithNoDefaultGiven] sum(Iterable[_SupportsSumNoDefaultT], /) -> _SupportsSumNoDefaultT | Literal[0] []',
        namespace = 33,
        severity = 3,
        source = 'mypy',
      },
      {
        bufnr = 3,
        col = 0,
        end_col = 4,
        end_lnum = 3,
        lnum = 3,
        message = '    def [_AddableT1 <: SupportsAdd[Any, Any], _AddableT2 <: SupportsAdd[Any, Any]] sum(Iterable[_AddableT1], /, start: _AddableT2) -> _AddableT1 | _AddableT2 []',
        namespace = 33,
        severity = 3,
        source = 'mypy',
      },
    }, diagnostics)
  end)
end)
