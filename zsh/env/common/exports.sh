if command -v nvim > /dev/null 2>&1; then
  export EDITOR='nvim'
fi

# Load NVM if it exists
if [[ -d "$HOME/.nvm" ]]; then
  export NVM_DIR="$HOME/.nvm"

  # Load NVM if the script exists
  if [[ -s "$NVM_DIR/nvm.sh" ]]; then
    . "$NVM_DIR/nvm.sh"
  fi

  # Load NVM bash completion if the script exists
  if [[ -s "$NVM_DIR/bash_completion" ]]; then
    . "$NVM_DIR/bash_completion"
  fi
fi

# Load SDKMAN if it exists
if [[ -d "$HOME/.sdkman" ]]; then
  export SDKMAN_DIR="$HOME/.sdkman"
  if [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
    source "$HOME/.sdkman/bin/sdkman-init.sh"
  fi
  export JAVA_HOME="$SDKMAN_DIR/candidates/java/current"
fi
