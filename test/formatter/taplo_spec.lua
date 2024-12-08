describe('taplo', function()
  it('can format', function()
    local ft = require('guard.filetype')
    ft('toml'):fmt('taplo')

    local formatted = require('test.formatter.helper').test_with('toml', {
      [[        [dependencies]        ]],
      [[           async-process = "^1.7"]],
      [[strum = {       version = "^0.25",   features = ["derive"]       } ]],
      [[anyhow     = "1" ]],
      [[tracing-error =     "0.2" ]],
      [[]],
      [[]],
    })
    assert.are.same({
      '[dependencies]',
      [[async-process = "^1.7"]],
      [[strum = { version = "^0.25", features = ["derive"] }]],
      [[anyhow = "1"]],
      [[tracing-error = "0.2"]],
    }, formatted)
  end)
end)
