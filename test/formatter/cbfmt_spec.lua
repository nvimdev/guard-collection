describe('cbfmt', function()
  it('can format', function()
    local ft = require('guard.filetype')
    ft('markdown'):fmt('cbfmt')
    require('guard').setup()

    local uv = vim.version().minor >= 10 and vim.uv or vim.loop
    local file = io.open(uv.cwd() .. '/.cbfmt.toml', 'w')
    if file then
      file:write('[languages]\nlua = ["stylua -s -"]\n')
      file:close()
    else
      return
    end
    local formatted = require('test.formatter.helper').test_with('markdown', {
      [[Normal text]],
      [[```lua]],
      [[local a = ]],
      [[		"a"]],
      [[```]],
    })
    assert.are.same({
      [[Normal text]],
      [[```lua]],
      [[local a = "a"]],
      [[```]],
    }, formatted)
  end)
end)
