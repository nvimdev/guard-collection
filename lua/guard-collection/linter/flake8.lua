local lint = require('guard.lint')

return {
  cmd = 'flake8',
  args = { '--format', 'default', '-', '--stdin-display-name' },
  stdin = true,
  fname = true,
  parse = lint.from_regex({
    source = 'flake8',
    regex = ':(%d+):(%d+):%s(%a)(%w+) (.+)',
    severities = {
      E = lint.severities.error,
      W = lint.severities.warning,
      C = lint.severities.warning,
      F = lint.severities.info,
    },
  }),
}
