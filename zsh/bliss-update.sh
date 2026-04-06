#!/usr/bin/env zsh
bliss-update() {
  # Print every command being executed
  set -x

  if [ ! -d "$ZSH" ]; then
    echo "oh-my-zsh is not installed. Please install it first from https://github.com/ohmyzsh/ohmyzsh"
    exit 1
  fi
  cd "$ZSH"
  git pull --rebase

  local REPO_DIR="$HOME/git/own/zsh-bliss"
  if [ ! -d "$REPO_DIR" ]; then
    echo "Repository directory $REPO_DIR does not exist."
    echo "Clone repository at https://github.com/Kira9204/zsh-bliss"
    exit 1
  fi
  cd "$REPO_DIR"

  echo "Pulling latest changes from zsh-bliss repository..."
  cd "$REPO_DIR"
  git pull --rebase

  echo "Updating zsh-bliss..."
  local backup_dir="$HOME/.zsh-backup-$(date +%Y%m%d%H%M%S)"
  echo "Backup current .zsh directory to $backup_dir"
  cp -r "$HOME/.zsh" "$backup_dir"

  echo "Copying zsh directory to $HOME/.zsh..."
  rm -rf "$HOME/.zsh"
  mkdir -p "$HOME/.zsh"
  cp -r ./zsh/. "$HOME/.zsh"

  echo "Installing oh-my-zsh plugins..."
  local autosuggestions_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
  local syntax_highlighting_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
  git clone https://github.com/zsh-users/zsh-autosuggestions "$autosuggestions_dir"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$syntax_highlighting_dir"
  cd "$REPO_DIR"

  echo "Adding back secrets"
  cp "$backup_dir/env/work/mac/secret-aliases.sh" "$HOME/.zsh/env/work/mac/secret-aliases.sh"
  cp "$backup_dir/env/work/mac/secret-exports.sh" "$HOME/.zsh/env/work/mac/secret-exports.sh"

  echo "Adding .vimrc to the home directory..."
  cp ./vim/vimrc "$HOME/.vimrc"

  echo "Copying neovim configuration..."
  rm -rf "$HOME/.config/nvim"
  mkdir -p "$HOME/.config/nvim"
  cp -r ./nvim/. "$HOME/.config/nvim"

  if command -v nvim > /dev/null 2>&1; then
    echo "Updating Neovim plugins..."
    nvim --headless "+Lazy! sync" +qa
  fi

  # Turn off printing every command being executed
  set +x
}
