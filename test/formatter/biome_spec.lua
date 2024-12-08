describe('biome', function()
  it('can format json', function()
    local ft = require('guard.filetype')

    local formatted = require('test.formatter.helper').test_with('json', {
      [[{"name":   "dove" , "age":10 ]],
      [[,"gender":   "male"}]],
    })
    assert.are.same({
      [[{ "name": "dove", "age": 10, "gender": "male" }]],
    }, formatted)
  end)

  it('can format javascript', function()
    local ft = require('guard.filetype')
    ft('js'):fmt('biome')

    local formatted = require('test.formatter.helper').test_with('js', {
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
