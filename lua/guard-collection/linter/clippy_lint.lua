local lint = require("guard.lint")

return {
  cmd = "clippy-driver",
  args = { "-", "--error-format=json" }, -- requires "--edition=XXXX" to be set
  stdin = true,
  parse = function(result, bufnr)
    
  end,
}
