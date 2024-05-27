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
  cmd = 'eslint_d',
  args = { '--fix-to-stdout', '--stdin', '--stdin-filename' },
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

M.latexindent = {
  cmd = 'latexindent',
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
  cmd = 'prettier',
  args = { '--stdin-filepath' },
  fname = true,
  stdin = true,
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
  stdin = true,
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

return M
