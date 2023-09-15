describe('clang-tidy', function()
  it('can lint', function()
    local ft = require('guard.filetype')
    ft('c'):lint('clang-tidy')
    require('guard').setup()

    local diagnostics = require('test.linter.helper').test_with('c', {
      [[#include <stdio.h>]],
      [[int main() {]],
      [[    int x = 10;]],
      [[    int y = 0;]],
      [[    printf("%d", x / y);]],
      [[    return 0;]],
      [[}]],
    })
    vim.print(diagnostics)
    assert.are.same({
      {
        bufnr = 3,
        col = 19,
        end_col = 19,
        end_lnum = 4,
        lnum = 4,
        message = 'Division by zero [clang-analyzer-core.DivideZero]',
        namespace = 1,
        severity = 2,
        source = 'clang-tidy',
      },
    }, diagnostics)
  end)
end)
