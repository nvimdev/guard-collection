describe('sql-formatter', function()
  it('can format', function()
    local ft = require('guard.filetype')
    ft('sql'):fmt('sql-formatter')
    require('guard').setup()

    local formatted = require('test.formatter.helper').test_with('sql', {
      [[SELECT          *]],
      [[FROM]],
      [[World]],
      [[WHERE   "Someone"]],
      [[        LIKE     '%YOU%']],
    })
    assert.are.same({
      [[SELECT]],
      [[  *]],
      [[FROM]],
      [[  World]],
      [[WHERE]],
      [[  "Someone" LIKE '%YOU%']],
      -- /> no results!
      -- /> :sob
    }, formatted)
  end)
end)
