describe('cpplint', function()
  it('can lint', function()
    local helper = require('test.helper')
    helper.run_lint_fn('cpplint', 'cpp', { [[int main(){int x=1;}]] }, function(bufnr, diagnostics)
      assert.is_true(#diagnostics > 0)
      for _, d in ipairs(diagnostics) do
        helper.assert_diag(d, { bufnr = bufnr, source = 'cpplint' })
        assert.is_number(d.lnum)
        assert.is_string(d.message)
      end
    end)
  end)
end)
