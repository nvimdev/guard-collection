describe('ktlint', function()
  it('can lint', function()
    local helper = require('test.linter.helper')
    local ns = helper.namespace
    local ft = require('guard.filetype')
    ft('kotlin'):lint('ktlint')
    require('guard').setup()

    local diagnostics = helper.test_with('kotlin', {
      [[fun main() {]],
      [[val fooooooooooooooo = "fooooooooooooooooooooo"]],
      [[}]],
    })
    assert.are.same({
      {
        bufnr = 3,
        col = 0,
        end_col = 0,
        end_lnum = 1,
        lnum = 1,
        message = 'Unexpected indentation (0) (should be 4) [standard:indent]',
        namespace = ns,
        severity = 1,
        source = 'ktlint',
      },
    }, diagnostics)
  end)
end)
