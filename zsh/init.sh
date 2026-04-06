#!/usr/bin/env zsh

source "$HOME/.zsh/lang.sh"
source "$HOME/.zsh/ls_colors.sh"
source "$HOME/.zsh/oh-my-zsh/init.sh"
source "$HOME/.zsh/normalize.sh"
source "$HOME/.zsh/bliss-update.sh"

local INIT_MAC="$HOME/.zsh/env/home/work/mac/init.sh"
local INIT_LINUX="$HOME/.zsh/env/home/linux/init.sh"
local INIT_LINUX_MSYS="$HOME/.zsh/env/home/windows/init.sh"

case "$(uname -s)" in
  Darwin)
    source "$INIT_MAC"
    ;;
  Linux)
    if grep -qi microsoft /proc/version 2> /dev/null; then
      source "$INIT_LINUX"
    else
      source "$INIT_LINUX"
    fi
    ;;
  MINGW* | MSYS* | CYGWIN*)
    source "$INIT_LINUX_MSYS"
    ;;
esac
