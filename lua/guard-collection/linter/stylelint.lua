local lint = require('guard.lint')

return {
  cmd = 'stylelint',
  args = { '--formatter', 'json', '--stdin', '--stdin-filename' },
  stdin = true,
  fname = true,
  parse = lint.from_json({
    get_diagnostics = function(...)
      return vim.json.decode(...)[1].warnings
    end,
    attributes = {
      lnum = 'line',
      end_lnum = 'endLine',
      col = 'column',
      end_col = 'endColumn',
      message = 'text',
      code = 'rule',
    },
    severities = {
      warning = lint.severities.warning,
      error = lint.severities.error,
    },
    source = 'stylelint',
  }),
}
