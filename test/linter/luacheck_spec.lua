describe('luacheck', function()
  it('can lint', function()
    local helper = require('test.linter.helper')
    local ns = helper.namespace
    local ft = require('guard.filetype')
    ft('lua'):lint('luacheck')
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
        message = "accessing undefined variable 'U' [113]",
        namespace = ns,
        severity = 2,
        source = 'luacheck',
      },
    }, diagnostics)
  end)
end)
