describe('rustfmt_nightly', function()
  it('can format', function()
    local ft = require('guard.filetype')
    ft('rust'):fmt('rustfmt_nightly')
    require('guard').setup()

    local formatted = require('test.formatter.helper').test_with('rust', {
      [[use std::{collections::HashMap, collections::HashSet};]],
      [[fn    main() {]],
      [[let   var:usize=1;]],
      [[          println!("{var}");]],
      [[}]],
    })
    assert.are.same({
      [[use std::collections::{HashMap, HashSet};]],
      [[fn main() {]],
      [[    let var: usize = 1;]],
      [[    println!("{var}");]],
      [[}]],
    }, formatted)
  end)
end)
