source "$HOME/.zsh/env/common/exports.sh"
source "$HOME/.zsh/env/work/mac/secret-exports.sh"

export EDITOR='nvim'

# Postgres CLI utils: brew install libpq
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# Visual Studio Code
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
# IntelliJ IDEA
export PATH="/Applications/IntelliJ IDEA.app/Contents/MacOS:$PATH"

# Docker
export DOCKER_DEFAULT_PLATFORM="linux/amd64"
