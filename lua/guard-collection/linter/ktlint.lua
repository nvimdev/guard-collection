local lint = require('guard.lint')

return {
  cmd = 'ktlint',
  args = { '--log-level=error' },
  fname = true,
  parse = lint.from_regex({
    source = 'ktlint',
    regex = ':(%d+):(%d+): (.+) %((.-)%)',
    groups = { 'lnum', 'col', 'message', 'code' },
  }),
}
