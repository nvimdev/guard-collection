local lint = require('guard.lint')

return {
  cmd = 'bundle',
  args = { 'exec', 'rubocop', '--format', 'json', '--force-exclusion', '--stdin' },
  stdin = true,
  parse = function(result, bufnr)
    local decoded = vim.json.decode(result)
    local diagnostics = {}
    local severities = {
      convention = lint.severities.info,
      error = lint.severities.error,
      fatal = lint.severities.fatal,
      info = lint.severities.info,
      refactor = lint.severities.style,
      warning = lint.severities.warning,
    }

    for _, diagnostic in ipairs(decoded.files[1].offenses) do
      table.insert(diagnostics, {
        bufnr = bufnr,
        source = 'rubocop',
        lnum = diagnostic.location.start_line,
        end_lnum = diagnostic.location.last_line,
        col = diagnostic.location.start_column,
        end_col = diagnostic.location.last_column,
        code = diagnostic.cop_name,
        severity = severities[diagnostic.severity],
        message = string.format('[%s] %s', diagnostic.cop_name, diagnostic.message),
      })
    end

    return diagnostics
  end,
}
