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
      [[class User {]],
      [[    /**]],
      [[     * This function checks if the name is valid]],
      [[     *]],
      [[     * @deprecated Useless]],
      [[     */]],
      [[    fun checkName(name: String) {]],
      [[        if (name.length > 42) {]],
      [[            throw IllegalArgumentException("username is too long")]],
      [[        }]],
      [[        // ...]],
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
        col = 6,
        end_col = 6,
        end_lnum = 0,
        lnum = 0,
        message = "The file name 'test' does not match the name of the single top-level declaration 'User'.[MatchingDeclarationName]",
        namespace = 1,
        severity = 4,
        source = 'detekt',
      },
      {
        bufnr = 3,
        col = 26,
        end_col = 26,
        end_lnum = 7,
        lnum = 7,
        message = 'This expression contains a magic number. Consider defining it to a well named constant.[MagicNumber]',
        namespace = 1,
        severity = 4,
        source = 'detekt',
      },
      {
        bufnr = 3,
        col = 12,
        end_col = 12,
        end_lnum = 8,
        lnum = 8,
        message = 'Use require() instead of throwing an IllegalArgumentException.[UseRequire]',
        namespace = 1,
        severity = 4,
        source = 'detekt',
      },
    }, diagnostics)
  end)
end)
