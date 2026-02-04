describe('checkmake', function()
  it('can lint', function()
    local helper = require('test.linter.helper')
    local ns = helper.namespace
    local ft = require('guard.filetype')
    ft('make'):lint('checkmake')

    local buf, diagnostics = helper.test_with('make', {
      [[all:]],
      [[\techo hello]],
    })
    assert.are.same({
      {
        bufnr = buf,
        col = 0,
        end_col = 0,
        end_lnum = 0,
        lnum = 0,
        message = '[minphony] Missing required phony target "all"',
        namespace = ns,
        severity = 2,
        source = 'checkmake',
      },
      {
        bufnr = buf,
        col = 0,
        end_col = 0,
        end_lnum = 0,
        lnum = 0,
        message = '[minphony] Missing required phony target "clean"',
        namespace = ns,
        severity = 2,
        source = 'checkmake',
      },
      {
        bufnr = buf,
        col = 0,
        end_col = 0,
        end_lnum = 0,
        lnum = 0,
        message = '[minphony] Missing required phony target "test"',
        namespace = ns,
        severity = 2,
        source = 'checkmake',
      },
    }, diagnostics)
  end)
end)
