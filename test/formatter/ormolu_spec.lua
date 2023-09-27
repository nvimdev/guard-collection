describe('ormolu', function()
  it('can format', function()
    local ft = require('guard.filetype')
    ft('haskell'):fmt('ormolu')
    require('guard').setup()

    -- Please don't judge my terrible haskell skills
    local formatted = require('test.formatter.helper').test_with('haskell', {
      [[module StrSplit where]],
      [[strsplit "" _ _ _ = return ()]],
      [[strsplit s sep h t]],
      [[    | rest == "" = putStrLn s]],
      [[    | (head rest) == sep = putStrLn (take t s) >> strsplit (drop 1 rest) sep (t+1) (t+1)]],
      [[    | otherwise = strsplit s sep h (t+1)]],
      [[    where rest = drop t s]],
      [[split s sep = strsplit s sep 1 1]],
    })
    assert.are.same({
      [[module StrSplit where]],
      [[]],
      [[strsplit "" _ _ _ = return ()]],
      [[strsplit s sep h t]],
      [[  | rest == "" = putStrLn s]],
      [[  | (head rest) == sep = putStrLn (take t s) >> strsplit (drop 1 rest) sep (t + 1) (t + 1)]],
      [[  | otherwise = strsplit s sep h (t + 1)]],
      [[  where]],
      [[    rest = drop t s]],
      [[]],
      [[split s sep = strsplit s sep 1 1]],
    }, formatted)
  end)
end)
