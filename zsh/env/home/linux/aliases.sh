source "$HOME/.zsh/env/common/aliases.sh"

# Generates a new .htpasswd entry
# Usage: htpasswd <username> <file>
# Example: htpasswd myuser /path/to/.htpasswd
# The password will be prompted securely
htpasswd() {
  printf "$1:$(openssl passwd -apr1)\n" >> $2
}

# Create a new WireGuard client configuration
new-wg-client() {
  wg genkey | tee privatekey | wg pubkey > publickey
}
