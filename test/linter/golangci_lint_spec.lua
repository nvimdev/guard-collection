describe('golangci-lint', function()
  it('can lint', function()
    local helper = require('test.linter.helper')
    local ft = require('guard.filetype')
    ft('go'):lint('golangci_lint')
    require('guard').setup()

    local diagnostics = helper.test_with('go', {
      [[package main]],
      [[]],
      [[import "fmt"]],
      [[]],
      [[func main() {]],
      [[	fmt.Println(]],
      [[    "Hi Mom!"]],
      [[    )]],
      [[}]],
    })
    assert.are.same({
      {
        bufnr = 3,
        col = 14,
        end_col = 14,
        end_lnum = 7,
        lnum = 7,
        message = [[missing ',' before newline in argument list]],
        namespace = 1,
        severity = 2,
        source = 'golangci-lint: typecheck',
      },
    }, diagnostics)
  end)
end)
