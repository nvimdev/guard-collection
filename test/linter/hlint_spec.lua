describe('hlint', function()
  it('can lint', function()
    local helper = require('test.linter.helper')
    local ns = helper.namespace
    local ft = require('guard.filetype')
    ft('haskell'):lint('hlint')
    require('guard').setup()

    local diagnostics = helper.test_with('haskell', {
      [[concat $ map escapeC s]],
      [[ftable ++ (map (\ (c, x) -> (toUpper c, urlEncode x)) ftable)]],
      [[mapM (delete_line (fn2fp f) line) old]],
    })
    assert.are.same({
      {
        bufnr = 3,
        col = 0,
        end_col = 0,
        end_lnum = 0,
        lnum = 0,
        message = 'Use concatMap: concatMap escapeC s',
        namespace = ns,
        severity = 2,
        source = 'hlint',
      },
      {
        bufnr = 3,
        col = 10,
        end_col = 10,
        end_lnum = 1,
        lnum = 1,
        message = [[Redundant bracket: ftable ++ map (\ (c, x) -> (toUpper c, urlEncode x)) ftable]],
        namespace = ns,
        severity = 3,
        source = 'hlint',
      },
      {
        bufnr = 3,
        col = 16,
        end_col = 16,
        end_lnum = 1,
        lnum = 1,
        message = 'Use bimap: Data.Bifunctor.bimap toUpper urlEncode',
        namespace = ns,
        severity = 3,
        source = 'hlint',
      },
    }, diagnostics)
  end)
end)
