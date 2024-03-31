local lint = require('guard.lint')

local function string.trim(s)
  return s:gsub("^%s*(.-)%s*$", "%1")
end

return {
  cmd = 'clippy-driver',
  args = { '-', '--error-format=json', '--edition=2021' } -- --edition-2021 is a mandatory, probably need a way to check Cargo.toml and get info from there
  stdin = true,
  parse = lint.from_json({
    get_diagnostics = function(...)
      error(...)
    end,
    attributes = {
      lnum = 'spans.line_start',
      end_lnum = 'spans.line_end',
      code = function(json)
        -- concat all 'spans.text[n].text'
        local str = ""
        for k,v in pairs(json.spans.text) do
            str = str .. v.text:trim() .. ";"
        end
        return str
      end,
      col = 'spans.column_start',
      end_col = 'spans.column_end',
      severity = 'level',
      message = 'message',
    },
    severities = {
      lint.severities.info,
      lint.severities.warning,
      lint.severities.error,
    },
  }),
}
