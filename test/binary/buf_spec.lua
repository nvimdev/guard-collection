describe('buf', function()
  it('can format', function()
    local ft = require('guard.filetype')
    ft('proto'):fmt('buf')
    local formatted = require('test.fmt_helper').test_with('proto', {
      [[syntax="proto3";]],
      [[message Foo{string bar=1;}]],
    })
    assert.are.same({
      [[syntax = "proto3";]],
      [[message Foo {]],
      [[  string bar = 1;]],
      [[}]],
    }, formatted)
  end)

  it('can lint', function()
    local helper = require('test.lint_helper')
    local ns = helper.namespace
    local ft = require('guard.filetype')
    ft('proto'):lint('buf')

    local buf, diagnostics = helper.test_with('proto', {
      [[syntax = "proto3";]],
      [[message foo {]],
      [[  string Bar = 1;]],
      [[}]],
    })
    helper.assert_diagnostics(diagnostics, {
      {
        bufnr = buf,
        col = 8,
        end_col = 0,
        end_lnum = 1,
        lnum = 1,
        message = 'Message name "foo" should be PascalCase, such as "Foo".',
        namespace = ns,
        severity = 2,
        source = 'buf',
        code = 'MESSAGE_PASCAL_CASE',
      },
      {
        bufnr = buf,
        col = 9,
        end_col = 0,
        end_lnum = 2,
        lnum = 2,
        message = 'Field name "Bar" should be lower_snake_case, such as "bar".',
        namespace = ns,
        severity = 2,
        source = 'buf',
        code = 'FIELD_LOWER_SNAKE_CASE',
      },
    })
  end)
end)
