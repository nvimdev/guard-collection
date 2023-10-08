local lint = require('guard.lint')

local severities = {
  error = lint.severities.ERROR,
  warning = lint.severities.WARN,
  refactor = lint.severities.INFO,
  convention = lint.severities.HINT,
}

return {
  cmd = 'golangci-lint',
  args = { 'run', '--fix=false', '--out-format=json' },
  fname = true,
  parse = function(result, bufnr)
    local diags = {}

    if result == '' then
      return diags
    end
    result = vim.json.decode(result)

    local issues = result.Issues
    if issues == nil or type(issues) == 'userdata' then
      return diags
    end
    if type(issues) == 'table' then
      for _, d in ipairs(issues) do
        table.insert(
          diags,
          lint.diag_fmt(
            bufnr,
            d.Pos.Line,
            d.Pos.Column,
            d.Text,
            severities[d.Severity] or lint.severities.warning,
            string.format('golangci-lint: %s', d.FromLinter)
          )
        )
      end
    end

    return diags
  end,
}
