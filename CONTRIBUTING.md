# Contributing to guard-collection

- Add your config to `formatter.lua` or `linter/<tool-name>.lua`, if it's a linter don't forget to export it in `linter/init.lua`
- Write a test. If it's a formatter, show that the config works by giving an example input and verify that the file did got formatted as intended. For example:

```lua
describe('black', function()
  it('can format', function()
    -- pre-test setup
    local ft = require('guard.filetype')
    ft('python'):fmt('black')
    require('guard').setup()
    -- Giving example input to the helper
    -- the helper creates a new buffer with it, formats, and returns the formatted output
    local formatted = require('test.formatter.helper').test_with('python', {
      -- The input code should somewhat reflect the filetype
      [[def foo(n):]],
      [[    if n in         (1,2,3):]],
      [[        return n+1]],
      [[a, b = 1,    2]],
      [[b, a =     a, b]],
      [[print(  f"The factorial of {a} is: {foo(a)}")]],
    })
    -- Show that the input is indeed formatted as intended
    assert.are.same({
      [[def foo(n):]],
      [[    if n in (1, 2, 3):]],
      [[        return n + 1]],
      [[]],
      [[]],
      [[a, b = 1, 2]],
      [[b, a = a, b]],
      [[print(f"The factorial of {a} is: {foo(a)}")]],
    }, formatted)
  end)
end)
```

- Or if it's a linter, show that the linter's output is converted correctly into neovim diagnostics

```lua
describe('selene', function()
  it('can lint', function()
    -- pre-test setup
    local ft = require('guard.filetype')
    ft('lua'):lint('selene')
    require('guard').setup()
    -- Giving example input to the helper
    -- the helper creates a new buffer with it, requires lint, and returns the diagnostics
    local diagnostics = require('test.linter.helper').test_with('lua', {
      -- Make sure the input actually has some problems that the linter detects
      [[local M = {}]],
      [[function M.foo()]],
      [[  print("foo")]],
      [[end]],
      [[U.bar()]],
      [[return M]],
    })
    -- Show that the diagnostics is indeed valid
    assert.are.same({
      {
        bufnr = 3,
        col = 0,
        end_col = 0,
        end_lnum = 4,
        lnum = 4,
        message = '`U` is not defined [undefined_variable]',
        namespace = 4,
        severity = 1,
        source = 'selene',
      },
    }, diagnostics)
  end)
end)

```

- To run the test you just created, install [vusted](https://github.com/notomo/vusted)
  ```shell
  luarocks --lua-version=5.1 install vusted
  ```
- Create a symlink so that vusted recognizes guard.nvim namespaces

```shell
ln -s ~/.local/share/nvim/lazy/guard.nvim/lua/guard lua
```

- Run the test and make sure it passes

  ```shell

  vusted ./test/formatter/<tool-name>_spec.lua
  # or
  vusted ./test/linter/<tool-name>\_spec.lua

  ok 1 - <tool-name> can format
  ok 1 - <tool-name> can lint
  ```

- Optionally, format the code with stylua
  ```shell
  stylua .
  ```
- Add the tool to the README list and you are good to go!
