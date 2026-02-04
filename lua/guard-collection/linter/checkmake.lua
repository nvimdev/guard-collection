local lint = require('guard.lint')

return {
  fn = function(_, fname)
    local co = assert(coroutine.running())
    vim.system({
      'checkmake',
      '--format={{.FileName}}:{{.LineNumber}}: [{{.Rule}}] {{.Violation}}\n',
      fname,
    }, {}, function(result)
      coroutine.resume(co, result.stdout or '')
    end)
    return coroutine.yield()
  end,
  parse = function(result, bufnr)
    local diags = {}
    for line in result:gmatch('[^\n]+') do
      local lnum, rule, msg = line:match(':(%d+): %[([^%]]+)%] (.+)$')
      if lnum then
        table.insert(
          diags,
          lint.diag_fmt(
            bufnr,
            tonumber(lnum),
            0,
            ('[%s] %s'):format(rule, msg),
            vim.diagnostic.severity.WARN,
            'checkmake'
          )
        )
      end
    end
    return diags
  end,
}
