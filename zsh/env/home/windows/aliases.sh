source "$HOME/.zsh/env/common/aliases.sh"

web-dev() {
  rm -rf /c/chrome_dev_session
  start brave.exe --user-data-dir="C://chrome_dev_session" --disable-web-security
}
