describe('gofmt', function()
  it('can format', function()
    local ft = require('guard.filetype')
    ft('go'):fmt('gofmt')
    require('guard').setup()

    local formatted = require('test.formatter.helper').test_with('go', {
      [[package         main]],
      [[]],
      [[     import   "fmt"     ]],
      [[]],
      [[func    main() {]],
      [[   x:=     1;]],
      [[          fmt.Println(x);]],
      [[}]],
    })
    assert.are.same({
      [[package main]],
      [[]],
      [[import "fmt"]],
      [[]],
      [[func main() {]],
      [[	x := 1]],
      [[	fmt.Println(x)]],
      [[}]],
    }, formatted)
  end)
end)
