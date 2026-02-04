#!/usr/bin/env -S nvim -l

local function get_test_names(base_dir)
  local tests = {}
  local handle = io.popen('find ' .. base_dir .. ' -name "*_spec.lua" 2>/dev/null')
  if handle then
    for line in handle:lines() do
      local name = line:match('/([^/]+)_spec%.lua$')
      if name then
        tests[name] = true
      end
    end
    handle:close()
  end
  return tests
end

local function get_keys(tbl, exclude)
  local keys = {}
  for k in pairs(tbl) do
    if not exclude[k] then
      table.insert(keys, k)
    end
  end
  table.sort(keys)
  return keys
end

package.path = 'lua/?.lua;lua/?/init.lua;' .. package.path

local formatters = require('guard-collection.formatter')
local linters = require('guard-collection.linter')

local all_tests = get_test_names('test')
local formatter_tests = all_tests
local linter_tests = all_tests

local formatter_exclude = { lsp = true }
local linter_exclude = { mypyc = true, dmypy = true }

local formatter_keys = get_keys(formatters, formatter_exclude)
local linter_keys = get_keys(linters, linter_exclude)

local missing_formatter_tests = {}
local missing_linter_tests = {}

for _, name in ipairs(formatter_keys) do
  if not formatter_tests[name] then
    table.insert(missing_formatter_tests, name)
  end
end

for _, name in ipairs(linter_keys) do
  if not linter_tests[name] then
    table.insert(missing_linter_tests, name)
  end
end

local has_missing = #missing_formatter_tests > 0 or #missing_linter_tests > 0

if has_missing then
  print('missing tests:\n')
  if #missing_formatter_tests > 0 then
    print('  formatters: ' .. table.concat(missing_formatter_tests, ', '))
  end
  if #missing_linter_tests > 0 then
    print('  linters: ' .. table.concat(missing_linter_tests, ', '))
  end
  print('')
  os.exit(1)
else
  print('all tools have tests')
  os.exit(0)
end
