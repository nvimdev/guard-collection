describe('detekt', function()
  it('can lint', function()
    local helper = require('test.linter.helper')
    local ns = helper.namespace
    local ft = require('guard.filetype')
    ft('kotlin'):lint('detekt')
    require('guard').setup()

    local cmd = require('guard.filetype')('kotlin').linter[1].cmd
    assert(vim.fn.executable(cmd) == 1)
    local bufnr = vim.api.nvim_create_buf(true, false)
    vim.bo[bufnr].filetype = 'kotlin'
    vim.api.nvim_set_current_buf(bufnr)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {
      [[fun main() {]],
      [[    if (4 == 4) {]],
      [[        println("aaa")]],
      [[    }]],
      [[}]],
    })
    -- To make linters happy
    vim.cmd('silent! write! /tmp/test.kt')
    require('guard.lint').do_lint(bufnr)
    vim.wait(3000)
    local diagnostics = vim.diagnostic.get(bufnr)

    assert.are.same({
      {
        bufnr = 3,
        col = 8,
        end_col = 8,
        end_lnum = 1,
        lnum = 1,
        message = 'This expression contains a magic number. Consider defining it to a well named constant. [MagicNumber]',
        namespace = ns,
        severity = 1,
        source = 'detekt',
      },
      {
        bufnr = 3,
        col = 13,
        end_col = 13,
        end_lnum = 1,
        lnum = 1,
        message = 'This expression contains a magic number. Consider defining it to a well named constant. [MagicNumber]',
        namespace = ns,
        severity = 1,
        source = 'detekt',
      },
    }, diagnostics)
  end)
end)
