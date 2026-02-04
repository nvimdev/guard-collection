return {
  cmd = 'buf',
  args = { 'lint', '--error-format=json' },
  fname = true,
  parse = require('guard.lint').from_json({
    lines = true,
    attributes = {
      lnum = 'start_line',
      col = 'start_column',
      end_lnum = 'end_line',
      end_col = 'end_column',
      code = 'type',
      message = 'message',
    },
    source = 'buf',
  }),
}
