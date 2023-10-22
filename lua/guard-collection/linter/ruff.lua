local lint = require('guard.lint')

return {
  cmd = 'ruff',
  args = {
    '-n',
    '-e',
    '--output-format',
    'json',
    '-',
    '--stdin-filename',
  },
  stdin = true,
  fname = true,
  parse = lint.from_json({
    attributes = {
      severity = 'type',
      lnum = function(js)
        return js['location']['row']
      end,
      col = function(js)
        return js['location']['column']
      end,
    },
    severities = {
      E = lint.severities.error, -- pycodestyle errors
      W = lint.severities.warning, -- pycodestyle warnings
      F = lint.severities.info, -- pyflakes
      A = lint.severities.info, -- flake8-builtins
      B = lint.severities.warning, -- flake8-bugbear
      C = lint.severities.warning, -- flake8-comprehensions
      T = lint.severities.info, -- flake8-print
      U = lint.severities.info, -- pyupgrade
      D = lint.severities.info, -- pydocstyle
      M = lint.severities.into, -- Meta
    },
    source = 'ruff',
  }),
}
