local lint = require('guard.lint')

return function(cmd, args)
  local opts = {
    offset = 1,
    severities = {
      error = lint.severities.error,
      warning = lint.severities.warning,
      note = lint.severities.info,
    },
    source = 'mypy',
  }

  -- see spec for pattern examples
  local full = {
    regex = '([^:]+):(%d+):(%d+):(%d+):(%d+): (%a+): (.*)  %[([%a-]+)%]',
    groups = { 'filename', 'lnum', 'col', 'end_lnum', 'end_col', 'severity', 'message', 'code' },
  }

  -- no err code
  local no_err = {
    regex = '([^:]+):(%d+):(%d+):(%d+):(%d+): (%a+): (.*)',
    groups = { 'filename', 'lnum', 'col', 'end_lnum', 'end_col', 'severity', 'message' },
  }

  return {
    cmd = cmd,
    args = args,
    fname = true,
    parse = function(result, bufnr)
      local diags, offences = {}, {}

      local lines = vim.split(result, '\n', { trimempty = true })

      for _, line in ipairs(lines) do
        local offence = {}

        local groups = full.groups
        local matches = { line:match(full.regex) }

        if #matches ~= #groups then
          matches = { line:match(no_err.regex) }
          groups = no_err.groups
        end

        -- regex matched
        if #matches == #groups then
          for i = 1, #groups do
            offence[groups[i]] = matches[i]
          end

          offences[#offences + 1] = offence
        end
      end

      vim.tbl_map(function(mes)
        local code = mes.code
        if not mes.code then
          code = ''
        end
        local diag = lint.diag_fmt(
          bufnr,
          tonumber(mes.lnum) - opts.offset,
          tonumber(mes.col) - opts.offset,
          ('%s [%s]'):format(mes.message, code),
          opts.severities[mes.severity],
          opts.source,
          nil,
          nil
        )

        diag.end_col = tonumber(mes.end_col) - opts.offset
        diag.end_lnum = tonumber(mes.end_lnum) - opts.offset
        diags[#diags + 1] = diag
      end, offences)

      return diags
    end,
  }
end
