describe('hadolint', function()
  it('can lint', function()
    local ft = require('guard.filetype')
    ft('dockerfile'):lint('hadolint')
    require('guard').setup()

    local diagnostics = require('test.linter.helper').test_with('dockerfile', {
      [[FROM alpine:3.18]],
      [[RUN {{Definitely not valid bash]],
      [[COPY foo bar]],
      [[ENV FOO=BAR]],
      'CMD ["bash"]',
    })
    assert.are.same({
      {
        bufnr = 3,
        col = 0,
        end_col = 0,
        end_lnum = 1,
        lnum = 1,
        message = "Missing '}'. Fix any mentioned problems and try again. [SC1072]",
        namespace = 4,
        severity = 1,
        source = 'hadolint',
      },
      {
        bufnr = 3,
        col = 0,
        end_col = 0,
        end_lnum = 2,
        lnum = 2,
        message = '`COPY` to a relative destination without `WORKDIR` set. [DL3045]',
        namespace = 4,
        severity = 2,
        source = 'hadolint',
      },
    }, diagnostics)
  end)
end)
