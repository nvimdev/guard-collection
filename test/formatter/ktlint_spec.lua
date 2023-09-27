describe('ktlint', function()
  it('can format', function()
    local ft = require('guard.filetype')
    ft('kotlin'):fmt('ktlint')
    require('guard').setup()

    local formatted = require('test.formatter.helper').test_with('kotlin', {
      [[fun main() {]],
      [[val foo =           "foooo".toUpperCase()]],
      [[        println("$foo ") }]],
    })
    assert.are.same({
      [[fun main() {]],
      [[    val foo = "foooo".toUpperCase()]],
      [[    println("$foo ")]],
      [[}]],
    }, formatted)
  end)
end)
