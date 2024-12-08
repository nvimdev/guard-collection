local M = {}

M.lsp = {
  fn = function(bufnr, range)
    vim.lsp.buf.format({ bufnr = bufnr, range = range, async = true })
  end,
}

M.autopep8 = {
  cmd = 'autopep8',
  args = { '-' },
  stdin = true,
}

M.black = {
  cmd = 'black',
  args = { '--quiet', '-' },
  stdin = true,
}

M.cbfmt = {
  cmd = 'cbfmt',
  args = { '--best-effort', '-p', 'markdown' },
  stdin = true,
}

M['clang-format'] = {
  cmd = 'clang-format',
  stdin = true,
}

M.csharpier = {
  cmd = 'dotnet-csharpier',
  args = { '--write-stdout' },
  stdin = true,
}

M.dart = {
  cmd = 'dart',
  args = { 'format' },
  stdin = true,
}

M.djhtml = {
  cmd = 'djhtml',
  args = { '-' },
  stdin = true,
}

M.docformatter = {
  cmd = 'docformatter',
  args = { '-' },
  stdin = true,
}

M.dprint = {
  cmd = 'dprint',
  args = { 'fmt', '--stdin' },
  stdin = true,
  fname = true,
  find = { 'dprint.json', 'dprint.jsonc', '.dprint.json', '.dprint.jsonc' },
}

M.eslint_d = {
  cmd = 'npx',
  args = { 'eslint_d', '--fix-to-stdout', '--stdin', '--stdin-filename' },
  fname = true,
  stdin = true,
}

M.fish_indent = {
  cmd = 'fish_indent',
  stdin = true,
}

M.fnlfmt = {
  cmd = 'fnlfmt',
  args = { '-' },
  stdin = true,
}

M.gofmt = {
  cmd = 'gofmt',
  stdin = true,
}

M.gofumpt = {
  cmd = 'gofumpt',
  stdin = true,
}

M.golines = {
  cmd = 'golines',
  args = { '--max-len=80' },
  stdin = true,
}

M['google-java-format'] = {
  cmd = 'google-java-format',
  args = { '-' },
  stdin = true,
}

M.isort = {
  cmd = 'isort',
  args = { '-' },
  stdin = true,
}

M.ktlint = {
  cmd = 'ktlint',
  args = { '-F', '--stdin', '--log-level=error' },
  stdin = true,
}

M.ktfmt = {
  cmd = 'ktfmt',
  args = { '-' },
  stdin = true,
}

M.latexindent = {
  cmd = 'latexindent',
  stdin = true,
}

M.mdformat = {
  cmd = 'mdformat',
  args = { '-' },
  stdin = true,
}

M.mixformat = {
  cmd = 'mix',
  args = { 'format', '-', '--stdin-filename' },
  stdin = true,
  fname = true,
}

M.nixfmt = {
  cmd = 'nixfmt',
  stdin = true,
}

M.ormolu = {
  cmd = 'ormolu',
  args = { '--color', 'never', '--stdin-input-file' },
  stdin = true,
  fname = true,
}

M.pg_format = {
  cmd = 'pg_format',
  stdin = true,
}

M.prettier = {
  cmd = 'npx',
  args = { 'prettier', '--stdin-filepath' },
  fname = true,
  stdin = true,
}

M.prettierd = {
  fn = function(buf, range)
    if vim.fn.has('nvim-0.10') ~= 1 then
      vim.notify('[guard-collection]: prettierd uses vim.system introduced in nvim 0.10', 4)
      return
    end
    local srow = range and range['start'][1] or 0
    local erow = range and range['end'][1] or -1
    local handle = vim.system(
      { 'prettierd', vim.api.nvim_buf_get_name(buf) },
      {
        stdin = true,
      },
      vim.schedule_wrap(function(result)
        if result.code ~= 0 then
          return
        end
        vim.api.nvim_buf_set_lines(buf, srow, erow, false, vim.split(result.stdout, '\r?\n'))
        vim.cmd('silent! noautocmd write!')
      end)
    )
    handle:write(table.concat(vim.api.nvim_buf_get_lines(buf, srow, erow, false), '\n'))
    handle:write(nil)
  end,
}

M.rubocop = {
  cmd = 'bundle',
  args = { 'exec', 'rubocop', '-A', '-f', 'quiet', '--stderr', '--stdin' },
  stdin = true,
  fname = true,
}

M.rustfmt = {
  cmd = 'rustfmt',
  args = { '--edition', '2021', '--emit', 'stdout' },
  stdin = true,
}

-- Use the nightly version of `rustfmt` even in projects based on the stable toolchain
-- The nightly version allows using more settings e.g. `wrap_comments` or `imports_granularity`
-- Details: https://rust-lang.github.io/rustfmt/
M.rustfmt_nightly = {
  cmd = 'rustup',
  args = { 'run', 'nightly', 'rustfmt', '--edition', '2021', '--emit', 'stdout' },
  stdin = true,
}

M.taplo = {
  cmd = 'taplo',
  args = { 'format', '-' },
  stdin = true,
}

M.shfmt = {
  cmd = 'shfmt',
  stdin = true,
}

M.stylua = {
  cmd = 'stylua',
  args = { '-' },
  stdin = true,
}

M.swiftformat = {
  cmd = 'swiftformat',
  args = { '--stdinpath' },
  stdin = true,
  fname = true,
}

M['swift-format'] = {
  cmd = 'swift-format',
  stdin = true,
}

M.sqlfluff = {
  cmd = 'sqlfluff',
  args = { 'format', '-' },
  stdin = true,
}

M.sqlfluff_fix = {
  cmd = 'sqlfluff',
  args = { 'fix', '-' },
  stdin = true,
}

M['sql-formatter'] = {
  cmd = 'sql-formatter',
  stdin = true,
}

M.yapf = {
  cmd = 'yapf',
  args = { '--quiet' },
  stdin = true,
}

M.ruff = {
  cmd = 'ruff',
  args = { 'format', '-' },
  stdin = true,
}

M.ruff_fix = {
  cmd = 'ruff',
  args = { '--fix', '-', '--stdin-filename' },
  stdin = true,
  fname = true,
}

M.zigfmt = {
  cmd = 'zig',
  args = { 'fmt', '--stdin' },
  stdin = true,
}

M.biome = {
  cmd = 'biome',
  args = { 'format', '--stdin-file-path' },
  fname = true,
  stdin = true,
}

M.xmllint = {
  cmd = 'xmllint',
  args = { '--format', '-' },
  stdin = true,
}

M.yamlfix = {
  cmd = 'yamlfix',
  args = { '-' },
  stdin = true,
}

M.yamlfmt = {
  cmd = 'yamlfmt',
  args = { '-' },
  stdin = true,
}

M.npm_groovy_lint = {
  cmd = 'npm-groovy-lint',
  args = { '--format', '-' },
  stdin = true,
}

M.npm_groovy_lint_fix = {
  cmd = 'npm-groovy-lint',
  args = { '--fix', '-' },
  stdin = true,
}

M.jq = {
  cmd = 'jq',
  stdin = true,
}

return M
