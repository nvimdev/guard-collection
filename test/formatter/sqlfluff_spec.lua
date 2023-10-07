describe('sqlfluff', function()
  it('can format', function()
    local ft = require('guard.filetype')
    local tool = ft('sql'):fmt('sqlfluff')
    tool.formatter[1].args = vim.list_extend(tool.formatter[1].args,{ '--dialect', 'ansi' })
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
end)
