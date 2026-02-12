local M = {}
local api = vim.api

function M.run_fmt(name, ft, input, opts)
  opts = opts or {}
  local config = require('guard-collection.formatter')[name]
  assert(config, 'unknown formatter: ' .. name)
  assert(not config.fn, name .. ' uses custom fn, not testable this way')
  local cmd = vim.list_extend({ config.cmd }, config.args or {})
  local dir = opts.tmpdir or '/tmp'
  local tmpfile = dir .. '/guard-test.' .. ft
  if config.fname then
    vim.fn.writefile(input, tmpfile)
    table.insert(cmd, tmpfile)
  end
  local result = vim
    .system(cmd, {
      stdin = config.stdin and (table.concat(input, '\n') .. '\n') or nil,
      cwd = opts.cwd,
    })
    :wait()
  assert(result.code == 0, name .. ' exited ' .. result.code .. ': ' .. (result.stderr or ''))
  if config.stdin then
    return vim.split(result.stdout, '\n', { trimempty = true })
  else
    return vim.fn.readfile(tmpfile)
  end
end

function M.run_lint(name, ft, input, opts)
  opts = opts or {}
  local linter = require('guard-collection.linter')[name]
  assert(linter, 'unknown linter: ' .. name)
  assert(not linter.fn, name .. ' uses custom fn — test parse() directly instead')
  local input_str = table.concat(input, '\n') .. '\n'
  local dir = opts.tmpdir or '/tmp'
  local tmpfile = dir .. '/guard-test.' .. ft
  vim.fn.writefile(input, tmpfile)
  local bufnr = api.nvim_create_buf(false, true)
  local cmd = vim.list_extend({ linter.cmd }, linter.args or {})
  if linter.fname then
    table.insert(cmd, tmpfile)
  end
  local result = vim
    .system(cmd, {
      stdin = linter.stdin and input_str or nil,
      cwd = opts.cwd,
    })
    :wait()
  local output = result.stdout or ''
  if output == '' then
    output = result.stderr or ''
  end
  local diags = linter.parse(output, bufnr)
  return bufnr, diags
end

function M.run_lint_fn(name, ft, input, assert_fn)
  local linter = require('guard-collection.linter')[name]
  assert(linter, 'unknown linter: ' .. name)
  assert(linter.fn, name .. ' does not use custom fn')
  local tmpfile = '/tmp/guard-test.' .. ft
  vim.fn.writefile(input, tmpfile)
  local bufnr = api.nvim_create_buf(false, true)
  local done = false
  local co = coroutine.create(function()
    local output = linter.fn(nil, tmpfile)
    local diags = linter.parse(output, bufnr)
    assert_fn(bufnr, diags)
    done = true
  end)
  coroutine.resume(co)
  vim.wait(5000, function()
    return done
  end)
  assert(done, name .. ' fn timed out')
end

function M.assert_diag(d, expect)
  local a = require('luassert')
  if expect.bufnr then
    a.equal(expect.bufnr, d.bufnr)
  end
  if expect.source then
    a.equal(expect.source, d.source)
  end
  if expect.severity then
    a.equal(expect.severity, d.severity)
  end
  if expect.lnum then
    a.equal(expect.lnum, d.lnum)
  end
  if expect.code then
    a.equal(expect.code, d.code)
  end
  if expect.message_pat then
    a.is_true(
      d.message ~= nil and d.message:find(expect.message_pat, 1, true) ~= nil,
      ('expected message containing %q, got %q'):format(expect.message_pat, d.message or '')
    )
  end
end

function M.get_linter(name)
  local linter = require('guard-collection.linter')[name]
  assert(linter, 'unknown linter: ' .. name)
  return linter
end

return M
