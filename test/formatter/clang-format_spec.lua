describe('clang-format', function()
  it('can format', function()
    local ft = require('guard.filetype')
    ft('c'):fmt('clang-format')
    require('guard').setup()

    local formatted = require('test.formatter.helper').test_with('c', {
      [[#include <stdio.h>]],
      [[int main() {]],
      [[                int x = 0x87654321]],
      [[                    ;]],
      [[int least_significant = 0xFF;]],
      [[    printf("0x%X\n", x ]],
      [[& least_significant);]],
      [[    return 0;]],
      [[}]],
    })
    assert.are.same({
      [[#include <stdio.h>]],
      [[int main() {]],
      [[  int x = 0x87654321;]],
      [[  int least_significant = 0xFF;]],
      [[  printf("0x%X\n", x & least_significant);]],
      [[  return 0;]],
      [[}]],
    }, formatted)
  end)
end)
