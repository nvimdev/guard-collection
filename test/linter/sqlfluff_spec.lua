describe('sqlfluff', function()
  it('can lint', function()
    local helper = require('test.linter.helper')
    local ft = require('guard.filetype')
    local tool = ft('sql'):lint('sqlfluff')
    tool.linter[1].args = vim.list_extend(tool.linter[1].args, { '--dialect', 'ansi' })
    require('guard').setup()

    local diagnostics = helper.test_with('sql', {
      [[SELECT a+b  AS foo,]],
      [[c AS bar from my_table]],
    })
    assert.are.same({
      {
        bufnr = 3,
        col = 0,
        end_col = 0,
        end_lnum = 0,
        lnum = 0,
        message = 'LT09: Select targets should be on a new line unless there is only one select target. [nil]',
        namespace = 1,
        severity = 3,
        source = 'sqlfluff',
      },
      {
        bufnr = 3,
        col = 0,
        end_col = 0,
        end_lnum = 0,
        lnum = 0,
        message = 'ST06: Select wildcards then simple targets before calculations and aggregates. [nil]',
        namespace = 1,
        severity = 3,
        source = 'sqlfluff',
      },
      {
        bufnr = 3,
        col = 6,
        end_col = 6,
        end_lnum = 0,
        lnum = 0,
        message = "LT02: Expected line break and indent of 4 spaces before 'a'. [nil]",
        namespace = 1,
        severity = 3,
        source = 'sqlfluff',
      },
      {
        bufnr = 3,
        col = 8,
        end_col = 8,
        end_lnum = 0,
        lnum = 0,
        message = "LT01: Expected single whitespace between naked identifier and binary operator '+'. [nil]",
        namespace = 1,
        severity = 3,
        source = 'sqlfluff',
      },
      {
        bufnr = 3,
        col = 9,
        end_col = 9,
        end_lnum = 0,
        lnum = 0,
        message = "LT01: Expected single whitespace between binary operator '+' and naked identifier. [nil]",
        namespace = 1,
        severity = 3,
        source = 'sqlfluff',
      },
      {
        bufnr = 3,
        col = 10,
        end_col = 10,
        end_lnum = 0,
        lnum = 0,
        message = "LT01: Expected only single space before 'AS' keyword. Found '  '. [nil]",
        namespace = 1,
        severity = 3,
        source = 'sqlfluff',
      },
      {
        bufnr = 3,
        col = 0,
        end_col = 0,
        end_lnum = 1,
        lnum = 1,
        message = 'LT02: Expected indent of 4 spaces. [nil]',
        namespace = 1,
        severity = 3,
        source = 'sqlfluff',
      },
      {
        bufnr = 3,
        col = 8,
        end_col = 8,
        end_lnum = 1,
        lnum = 1,
        message = "LT02: Expected line break and no indent before 'from'. [nil]",
        namespace = 1,
        severity = 3,
        source = 'sqlfluff',
      },
      {
        bufnr = 3,
        col = 9,
        end_col = 9,
        end_lnum = 1,
        lnum = 1,
        message = 'CP01: Keywords must be consistently upper case. [nil]',
        namespace = 1,
        severity = 3,
        source = 'sqlfluff',
      },
    }, diagnostics)
  end)
end)
