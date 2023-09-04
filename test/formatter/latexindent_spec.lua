describe('latexindent', function()
  it('can format', function()
    local ft = require('guard.filetype')
    ft('latex'):fmt('latexindent')
    require('guard').setup()

    local formatted = require('test.formatter.helper').test_with('latex', {
      [[\documentclass{article}]],
      [[\begin{document}]],
      [[Shopping list]],
      [[\begin{itemize}]],
      [[\item 1. eggs]],
      [[\item 2. butter]],
      [[\item 3. bread]],
      [[\end{itemize}]],
      [[\end{document}]],
    })
    assert.are.same({
      [[\documentclass{article}]],
      [[\begin{document}]],
      [[Shopping list]],
      [[\begin{itemize}]],
      '\t\\item 1. eggs',
      '\t\\item 2. butter',
      '\t\\item 3. bread',
      [[\end{itemize}]],
      [[\end{document}]],
    }, formatted)
  end)
end)
