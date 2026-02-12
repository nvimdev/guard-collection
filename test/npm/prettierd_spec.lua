describe('prettierd', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('prettierd', 'js', {
      'const x={a:1,b:2,c:3}',
      'const y = [1,2,3,4,5]',
    })
    assert.are.same({
      'const x = { a: 1, b: 2, c: 3 };',
      'const y = [1, 2, 3, 4, 5];',
    }, formatted)
  end)
end)
