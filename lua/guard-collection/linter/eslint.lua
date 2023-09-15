local lint = require('guard.lint')

return {
  cmd = 'eslint',
  args = { '--format', 'json', '--stdin', '--stdin-filename' },
  stdin = true,
  fname = true,
  find = {
    '.eslintrc.js',
    '.eslintrc.cjs',
    '.eslintrc.yaml',
    '.eslintrc.yml',
    '.eslintrc.json',
  },
  parse = lint.from_json({
    get_diagnostics = function(...)
      return vim.json.decode(...)[1].messages
    end,
    attributes = {
      lnum = 'line',
      end_lnum = 'endLine',
      col = 'column',
      end_col = 'endColumn',
      message = 'message',
      code = 'ruleId',
    },
    severities = {
      lint.severities.warning,
      lint.severities.error,
    },
    source = 'eslint',
  }),
}
