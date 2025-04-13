describe('alejandra', function()
  it('can format', function()
    -- pre-test setup
    local ft = require('guard.filetype')
    ft('nix'):fmt('alejandra')
    -- Giving example input to the helper
    -- the helper creates a new buffer with it, formats, and returns the formatted output
    local formatted = require('test.formatter.helper').test_with('nix', {
      -- The input code should somewhat reflect the filetype
      [[{inputs={nixpkgs.url="github:NixOS/nixpkgs/nixos-unstable";};}]],
    })
    -- Show that the input is indeed formatted as intended
    assert.are.same({
      [[{inputs = {nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";};}]],
    }, formatted)
  end)
end)
