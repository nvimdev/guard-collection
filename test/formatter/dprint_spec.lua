describe('dprint', function()
  it('can format', function()
    local ft = require('guard.filetype')
    ft('typescriptreact'):fmt('dprint')
    require('guard').setup()

    local formatted = require('test.formatter.helper').test_with('typescriptreact', {
      [[            const randomNumber = Math.floor(]],
      [[      Math.random() *           10]],
      [[      ) + 1]],
      [[alert(randomNumber)]],
    })
    assert.are.same({
      [[const randomNumber = Math.floor(Math.random() * 10) + 1;]],
      [[alert(randomNumber);]],
    }, formatted)
  end)
end)
