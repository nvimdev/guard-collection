return {
  ['clang-tidy'] = require('guard-collection.linter.clang-tidy'),
  ['editorconfig-check'] = require('guard-collection.linter.editorconfig-check'),
  codespell = require('guard-collection.linter.codespell'),
  flake8 = require('guard-collection.linter.flake8'),
  hadolint = require('guard-collection.linter.hadolint'),
  luacheck = require('guard-collection.linter.luacheck'),
  pylint = require('guard-collection.linter.pylint'),
  rubocop = require('guard-collection.linter.rubocop'),
  selene = require('guard-collection.linter.selene'),
  shellcheck = require('guard-collection.linter.shellcheck'),
}
