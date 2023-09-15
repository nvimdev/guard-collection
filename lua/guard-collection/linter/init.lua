local linter_dir = vim.fn.fnamemodify(debug.getinfo(1).source:sub(2), ':h')
local linter_files = vim.fn.readdir(linter_dir)

local linters = {}

for _, linter_file in ipairs(linter_files) do
  if linter_file ~= 'init.lua' then
    local linter_name = vim.fn.fnamemodify(linter_file, ':t:r')

    linters[linter_name] = require('guard-collection.linter.' .. linter_name)
  end
end

return linters
