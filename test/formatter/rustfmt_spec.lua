describe('rustfmt', function()
  it('can format', function()
    local ft = require('guard.filetype')
    ft('rust'):fmt('rustfmt')
    require('guard').setup()

    local formatted = require('test.formatter.helper').test_with('rust', {
      [[fn    main() {]],
      [[let   var:usize=1;]],
      [[          println!("{var}");]],
      [[}]],
    })
    assert.are.same({
      [[fn main() {]],
      [[    let var: usize = 1;]],
      [[    println!("{var}");]],
      [[}]],
    }, formatted)
  end)
end)
