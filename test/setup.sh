#! /bin/bash
# Install homebrew
sudo apt-get install -qqq build-essential
CI=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# Install packages with package managers
sudo apt-get install -qqq \
    clang-format clang-tidy fish elixir &
luarocks install luacheck &
go install github.com/segmentio/golines@latest &
pip -qqq install autopep8 black djhtml flake8 isort pylint yapf codespell &
npm install -g --silent \
    prettier @fsouza/prettierd sql-formatter shellcheck shfmt &
gem install -q rubocop &
# Block, homebrew takes the longest time
brew install \
    swiftformat swift-format hadolint google-java-format pgformatter fnlfmt ormolu

# Install standalone binary packages
bin="/home/runner/.local/bin"
gh="https://github.com"
# cbfmt
wget -q $gh"/lukas-reineke/cbfmt/releases/download/v0.2.0/cbfmt_linux-x86_64_v0.2.0.tar.gz"
tar -xvf cbfmt_linux-x86_64_v0.2.0.tar.gz
mv ./cbfmt_linux-x86_64_v0.2.0/cbfmt $bin
chmod +x $bin/cbfmt
# selene
wget -q "$gh/Kampfkarren/selene/releases/download/0.25.0/selene-0.25.0-linux.zip"
unzip selene-0.25.0-linux.zip -d $bin
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
wget -q https://github.com/pinterest/ktlint/releases/download/1.0.0/ktlint
chmod +x ktlint 
mv ktlint $bin/ktlint

# test setup
luarocks install vusted
git clone https://github.com/nvimdev/guard.nvim /home/runner/guard.nvim
mv /home/runner/guard.nvim/lua/guard ./lua/
