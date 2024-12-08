describe('flake8', function()
  it('can lint', function()
    local helper = require('test.linter.helper')
    local ns = helper.namespace
    local ft = require('guard.filetype')
    ft('python'):lint('flake8')

    local diagnostics = helper.test_with('python', {
      [[import os]],
      [[]],
      [[def foo(n):]],
      [[    if n == 0:]],
      [[         return  bar]],
      [[print("it's too long sentence to be displayed in one line, blah blah blah blah")]],
    })
    assert.are.same({
      {
        bufnr = 3,
        col = 0,
        end_col = 0,
        end_lnum = 0,
        lnum = 0,
        message = "'os' imported but unused[401]",
        namespace = ns,
        severity = 3,
        source = 'flake8',
      },
      {
        bufnr = 3,
        col = 0,
        end_col = 0,
        end_lnum = 2,
        lnum = 2,
        message = 'expected 2 blank lines, found 1[302]',
        namespace = ns,
        severity = 1,
        source = 'flake8',
      },
      {
        bufnr = 3,
        col = 9,
        end_col = 9,
        end_lnum = 4,
        lnum = 4,
        message = 'indentation is not a multiple of 4[111]',
        namespace = ns,
        severity = 1,
        source = 'flake8',
      },
      {
        bufnr = 3,
        col = 9,
        end_col = 9,
        end_lnum = 4,
        lnum = 4,
        message = 'over-indented[117]',
        namespace = ns,
        severity = 1,
        source = 'flake8',
      },
      {
        bufnr = 3,
        col = 15,
        end_col = 15,
        end_lnum = 4,
        lnum = 4,
        message = 'multiple spaces after keyword[271]',
        namespace = ns,
        severity = 1,
        source = 'flake8',
      },
      {
        bufnr = 3,
        col = 17,
        end_col = 17,
        end_lnum = 4,
        lnum = 4,
        message = "undefined name 'bar'[821]",
        namespace = ns,
        severity = 3,
        source = 'flake8',
      },
      {
        bufnr = 3,
        col = 0,
        end_col = 0,
        end_lnum = 5,
        lnum = 5,
        message = 'expected 2 blank lines after class or function definition, found 0[305]',
        namespace = ns,
        severity = 1,
        source = 'flake8',
      },
      {
        bufnr = 3,
        col = 79,
        end_col = 79,
        end_lnum = 5,
        lnum = 5,
        message = 'line too long (80 > 79 characters)[501]',
        namespace = ns,
        severity = 1,
        source = 'flake8',
      },
    }, diagnostics)
  end)
end)
