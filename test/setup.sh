#! /bin/bash
# Setup homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Install packages with package managers
luarocks install luacheck &

pip -qqq install autopep8 black djhtml docformatter flake8 isort pylint yapf codespell ruff sqlfluff clang-tidy mypy &

npm install -g --silent \
    prettier @fsouza/prettierd sql-formatter shellcheck shfmt @taplo/cli @biomejs/biome &

brew install \
    hlint ormolu clang-format golines gofumpt detekt swiftformat &

# Install standalone binary packages
bin="$HOME/.local/bin"
gh="https://github.com"
mkdir -p $bin

# alejandra
wget -q $gh"/kamadorueda/alejandra/releases/download/4.0.0/alejandra-x86_64-unknown-linux-musl"
mv ./alejandra-x86_64-unknown-linux-musl $bin/alejandra
chmod +x $bin/alejandra

# cbfmt
wget -q $gh"/lukas-reineke/cbfmt/releases/download/v0.2.0/cbfmt_linux-x86_64_v0.2.0.tar.gz"
tar -xvf cbfmt_linux-x86_64_v0.2.0.tar.gz
mv ./cbfmt_linux-x86_64_v0.2.0/cbfmt $bin
chmod +x $bin/cbfmt

# selene
wget -q "$gh/Kampfkarren/selene/releases/download/0.28.0/selene-0.28.0-linux.zip"
unzip selene-0.28.0-linux.zip -d $bin
chmod +x $bin/selene

# stylua
wget -q "$gh/JohnnyMorganz/StyLua/releases/download/v0.18.0/stylua-linux.zip"
unzip stylua-linux.zip -d $bin
chmod +x $bin/stylua

# latexindent
wget -q "$gh/cmhughes/latexindent.pl/releases/download/V3.22.2/latexindent-linux"
chmod +x latexindent-linux
mv latexindent-linux $bin/latexindent

# nixfmt
wget -q "$gh/serokell/nixfmt/releases/download/v0.5.0/nixfmt"
chmod +x nixfmt
mv nixfmt $bin/nixfmt

# ktlint
wget -q "$gh/pinterest/ktlint/releases/download/1.0.0/ktlint"
chmod +x ktlint 
mv ktlint $bin/ktlint

# test setup
export PATH="$HOME/.local/bin:$PATH"
luarocks install vusted
git clone "$gh/nvimdev/guard.nvim" "$HOME/guard.nvim"
mv "$HOME/guard.nvim/lua/guard" ./lua/
wait
