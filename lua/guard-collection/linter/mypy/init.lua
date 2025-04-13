local base = require('guard-collection.linter.mypy.base')

local args = {
  '--hide-error-codes',
  '--hide-error-context',
  '--no-color-output',
  '--show-absolute-path',
  '--show-column-numbers',
  '--show-error-codes',
  '--show-error-end',
  '--no-error-summary',
  '--no-pretty',
  '--follow-imports=silent',
}

return {
  mypy = base('mypy', args),
  mypyc = base('mypyc', args),
  dmypy = base('dmypy', { 'run', '--', unpack(args) }),
}
