describe('buf', function()
  it('can format', function()
    local ft = require('guard.filetype')
    ft('proto'):fmt('buf')

    local formatted = require('test.formatter.helper').test_with('proto', {
      [[syntax = "proto3"; message Foo { string bar = 1; }]],
    })
    assert.are.same({
      [[syntax = "proto3";]],
      [[]],
      [[message Foo {]],
      [[  string bar = 1;]],
      [[}]],
    }, formatted)
  end)
end)
