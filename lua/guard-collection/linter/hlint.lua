local lint = require('guard.lint')

local severities = {
  suggestion = lint.severities.info,
  warning = lint.severities.warning,
  error = lint.severities.error,
}

return {
  cmd = 'hlint',
  args = { '--json', '--no-exit-code' },
  fname = true,
  parse = function(result, bufnr)
    local diags = {}

    result = result ~= '' and vim.json.decode(result) or {}
    for _, d in ipairs(result) do
      table.insert(
        diags,
        lint.diag_fmt(
          bufnr,
          d.startLine > 0 and d.startLine - 1 or 0,
          d.startLine > 0 and d.startColumn - 1 or 0,
          d.hint .. (d.to ~= vim.NIL and (': ' .. d.to) or ''),
          severities[d.severity:lower()],
          'hlint'
        )
      )
    end

    return diags
  end,
}
