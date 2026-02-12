describe('zsh', function()
  it('can lint', function()
    local helper = require('test.helper')
    helper.run_lint_fn('zsh', 'zsh', { 'if true; then' }, function(bufnr, diagnostics)
      assert.is_true(#diagnostics > 0)
      for _, d in ipairs(diagnostics) do
        helper.assert_diag(d, { bufnr = bufnr, source = 'zsh' })
        assert.is_number(d.lnum)
        assert.is_string(d.message)
      end
    end)
  end)
end)
