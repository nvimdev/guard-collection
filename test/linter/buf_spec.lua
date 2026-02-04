describe('buf', function()
  it('can lint', function()
    local helper = require('test.linter.helper')
    local ns = helper.namespace
    local ft = require('guard.filetype')
    ft('proto'):lint('buf')

    local buf, diagnostics = helper.test_with('proto', {
      [[syntax = "proto3"; message Foo { string bar = 1 }]],
    })
    assert.are.same({
      {
        bufnr = buf,
        col = 48,
        end_col = 48,
        end_lnum = 0,
        lnum = 0,
        message = "syntax error: expecting ';'",
        namespace = ns,
        severity = 4,
        source = 'buf',
      },
    }, diagnostics)
  end)
end)
