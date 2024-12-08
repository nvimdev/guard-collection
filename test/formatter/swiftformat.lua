describe('swiftformat', function()
  it('can format', function()
    local ft = require('guard.filetype')
    ft('swift'):fmt('swiftformat')

    local formatted = require('test.formatter.helper').test_with('swift', {
      [[func myFunc()        { ]],
      [[print("hello")  ]],
      [[  }]],
    })
    assert.are.same({
      [[func myFunc() {]],
      [[    print("hello")]],
      [[}]],
    }, formatted)
  end)
end)
