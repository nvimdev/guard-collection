local lint = require('guard.lint')

return {
  cmd = 'editorconfig-checker',
  args = { '-no-color' },
  fname = true,
  stdin = true,
  parse = function(result, bufnr)
    local lines = vim.split(result, '\n', { trimempty = true })
    local diagnostics = {}

    for _, line in ipairs(lines) do
      local matches = { line:match([[(%d+): (.+)]]) }
      if #matches > 0 then
        table.insert(diagnostics, {
          bufnr = bufnr,
          source = 'editorconfig',
          severity = lint.severities.warning,
          lnum = tonumber(matches[1]) - 1,
          col = 1,
          message = matches[2],
        })
      end
    end

    return diagnostics
  end,
}
