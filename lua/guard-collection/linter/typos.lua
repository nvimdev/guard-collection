local lint = require('guard.lint')
return {
  cmd = 'typos',
  stdin = false,
  fname = true,
  args = { '--format=json', '--force-exclude' },
  parse = function(result, bufnr)
    if result == '' then
      return {}
    end

    local diagnostics = {}

    for json in string.gmatch(result, '[%S]+') do
      local item = vim.json.decode(json)

      if item ~= nil and item.line_num ~= nil then
        local line_num = item.line_num - 1
        local corrections = table.concat(item.corrections, ' / ')

        table.insert(
          diagnostics,
          lint.diag_fmt(
            bufnr,
            line_num,
            item.byte_offset,
            string.format('`%s` should be `%s`', item.typo, corrections),
            vim.diagnostic.severity.WARN,
            '[typos] ' .. item.type,
            line_num,
            item.byte_offset + item.type:len()
          )
        )
      end
    end

    return diagnostics
  end,
}
