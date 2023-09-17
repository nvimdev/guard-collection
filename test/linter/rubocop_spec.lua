describe('rubocop', function()
  it('can lint', function()
    local helper = require('test.linter.helper')
    local ns = helper.namespace
    local ft = require('guard.filetype')
    ft('ruby'):lint('rubocop')
    require('guard').setup()

    local diagnostics = helper.test_with('lua', {
      [[class foo]],
      [[end]],
    })
    assert.are.same({
      {
        bufnr = 3,
        col = 7,
        end_col = 9,
        end_lnum = 1,
        lnum = 1,
        message = [[class or module name must be a constant literal
(Using Ruby 3.0 parser; configure using `TargetRubyVersion` parameter, under `AllCops`)]],
        namespace = ns,
        severity = 1,
        source = 'rubocop',
      },
    }, diagnostics)
  end)
end)
