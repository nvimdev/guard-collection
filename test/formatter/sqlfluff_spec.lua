describe('sqlfluff', function()
  it('can format', function()
    local ft = require('guard.filetype')
    local tool = ft('sql'):fmt('sqlfluff')
    tool.formatter[1].args = vim.list_extend(tool.formatter[1].args, { '--dialect', 'ansi' })
    require('guard').setup()

    local formatted = require('test.formatter.helper').test_with('sql', {
      [[SELECT          *]],
      [[FROM]],
      [[         World         ]],
      [[WHERE   "Someone"]],
      [[        LIKE     '%YOU%']],
    })
    assert.are.same({
      [[SELECT *]],
      [[FROM]],
      [[    World]],
      [[WHERE]],
      [[    "Someone"]],
      [[    LIKE '%YOU%']],
    }, formatted)
  end)

  it('can fix', function()
    local ft = require('guard.filetype')
    local tool = ft('sql'):fmt('sqlfluff_fix')
    tool.formatter[1].args = vim.list_extend(tool.formatter[1].args, { '--dialect', 'ansi' })
    require('guard').setup()

    local formatted = require('test.formatter.helper').test_with('sql', {
      [[SELECT]],
      [[    a + b  AS foo,]],
      [[    c AS bar]],
      [[FROM my_table]],
    })
    assert.are.same({
      [[SELECT]],
      [[    c AS bar,]],
      [[    a + b AS foo]],
      [[FROM my_table]],
    }, formatted)
  end)
end)
