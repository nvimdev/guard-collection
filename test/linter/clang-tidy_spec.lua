describe('clang-tidy', function()
  it('can lint', function()
    local helper = require('test.linter.helper')
    local ns = helper.namespace
    local ft = require('guard.filetype')
    ft('c'):lint('clang-tidy')
    require('guard').setup()

    local diagnostics = helper.test_with('c', {
      [[#include <stdio.h>]],
      [[int main() {]],
      [[    int x = 10;]],
      [[    int y = 0;]],
      [[    printf("%d", x / y);]],
      [[    return 0;]],
      [[}]],
    })
    assert.are.same({
      {
        bufnr = 3,
        col = 19,
        end_col = 19,
        end_lnum = 4,
        lnum = 4,
        message = 'Division by zero[clang-analyzer-core.DivideZero]',
        namespace = ns,
        severity = 2,
        source = 'clang-tidy',
      },
    }, diagnostics)
  end)
end)
