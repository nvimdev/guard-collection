describe('cmake-format', function()
  it('can format', function()
    local ft = require('guard.filetype')
    ft('cmake'):fmt('cmake-format')

    local formatted = require('test.formatter.helper').test_with('cmake', {
      [[cmake_minimum_required(VERSION 3.10)]],
      [[project(test)]],
      [[add_executable(test main.cpp)]],
    })
    assert.are.same({
      [[cmake_minimum_required(VERSION 3.10)]],
      [[project(test)]],
      [[add_executable(test main.cpp)]],
    }, formatted)
  end)
end)
