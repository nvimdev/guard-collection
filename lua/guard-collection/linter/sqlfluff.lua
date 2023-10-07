local lint = require('guard.lint')

return {
  cmd = 'sqlfluff',
  args = { 'lint', '-f', 'github-annotation' },
  stdin = true,
  parse = lint.from_json({
    attributes = {
      row = 'line',
      col = 'start_column',
      end_col = 'end_column',
      severity = 'annotation_level',
      message = 'message',
    },
    severities = {
      notice = lint.severities.info,
      warning = lint.severities.warning,
      error = lint.severities.error,
    },
    source = 'sqlfluff',
  }),
}
