local lint = require('guard.lint')

return {
  cmd = 'detekt',
  args = { '-i' },
  fname = true,
  parse = lint.from_regex({
    source = 'detekt',
    regex = ':(%d+):(%d+):%s(.+)%s%[(.+)%]',
    groups = { 'lnum', 'col', 'message', 'code' },
  }),
}
