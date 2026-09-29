if command -v lsd > /dev/null 2>&1; then

  local icons="always"
  # If we are inside an SSH or physical terminal session
  if [[ $(tty) == /dev/tty[1-6] ]]; then
    icons="never"
  fi

  alias ls="lsd --group-dirs=first --color=always --icon $icons"
else
  alias ls="ls --color=auto"
fi

if command -v bat > /dev/null 2>&1; then
  alias cat="bat --paging=never --style=plain"
fi

blk() {
  lsblk -o NAME,SIZE,FSTYPE,TYPE,UUID,MODEL,SERIAL
}

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# List with details
alias ll="ls -al"
# List last access time
alias lt="ls -lt"

alias sy="rsync -ah --info=progress2"
alias l="ls"
alias s="ls"
alias ll="ls -l"
alias la="ls -Al"
alias all="ls -Al"
alias sl="ls"
alias cpr="cp -r"
alias rmr="rm -rf"

# Print the current working directory every time we change it
cd() {
  builtin cd "$@" && ls
}

mk() {
  mkdir -p "$@" && builtin cd "$@"
}

# Reload the shell configuration
reload() {
  source ~/.zshrc
}

# SSH related aliases
ssh-gen-key() {
  ssh-keygen -t ed25519 -C "$1"
}
ssh-copy-key() {
  ssh-copy-id "$1"
}

# Git related aliases
checkout() {
  git checkout "$@"
}
status() {
  git status
}
add() {
  git add -v "$@"
}
pull() {
  git pull --rebase
}
push() {
  git push
}
pushh() {
  git push -f
}
commit() {
  git commit -m "$1"
}
reset() {
  if [ -z $1 ]; then
    git reset --hard HEAD
  else
    git reset --hard HEAD~$1
  fi
}
rebase() {
  local target="${1:-}"

  if [[ -z "$target" ]]; then
    echo "Usage: rebase <number|commit>" >&2
    return 1
  fi

  if [[ "$target" =~ ^[0-9]+$ ]]; then
    git rebase -i "HEAD~$target"
  else
    git rebase -i "$target"
  fi
}

reset-commit() {
  git commit --amend --reset-author --no-edit
}

# Build a 256-color ANSI escape sequence for the given foreground/background
# color numbers (either may be blank to omit that part).
_ansi_256_color() {
  local fg="$1" bg="$2"
  if [[ -z "$fg" && -z "$bg" ]]; then
    return
  elif [[ -z "$bg" ]]; then
    printf '\033[38;5;%sm' "$fg"
  elif [[ -z "$fg" ]]; then
    printf '\033[48;5;%sm' "$bg"
  else
    printf '\033[38;5;%s;48;5;%sm' "$fg" "$bg"
  fi
}

log() {
  local command="${1:-}"
  local branch_format
  local -a git_log_args

  case "$command" in
    "")
      git_log_args=(-20)
      branch_format="$(git branch --show-current)"
      ;;
    a | all)
      git_log_args=(-20 --all --source)
      branch_format="%S"
      ;;
    *)
      echo "Usage:"
      echo "  log       - Displays the latest 20 commits on your current branch"
      echo "  log a|all - Displays the latest 20 commits across all refs"
      return 1
      ;;
  esac

  local reset=$'\033[0m'
  local line_number_color="$(_ansi_256_color 6 "")"
  local commit_hash_color="$(_ansi_256_color "" "")"
  local branch_color="$(_ansi_256_color 2 "")"
  local message_color="$(_ansi_256_color 3 "")"

  # awk just wires the pre-built colors around each tab-separated field;
  # all the color-code math happens above, in bash.
  git log "${git_log_args[@]}" --pretty=format:"%h%x09${branch_format}%x09%s" \
    | awk -F '\t' \
      -v reset="$reset" \
      -v line_number_color="$line_number_color" \
      -v commit_hash_color="$commit_hash_color" \
      -v branch_color="$branch_color" \
      -v message_color="$message_color" '
    {
        sub(/^refs\/heads\//, "", $2)
        sub(/^refs\/remotes\//, "", $2)
        printf "%s%2d%s %s%s%s %s%s%s %s%s%s\n",
          line_number_color, NR, reset,
          commit_hash_color, $1, reset,
          branch_color, $2, reset,
          message_color, $3, reset
    }'
}

stash() {
  local command="${1:-}"
  shift
  case "$command" in

    list)
      git stash list
      ;;

    add)
      if [[ $# -eq 0 ]]; then
        echo "Usage: stash add \"name\""
        return 1
      fi

      git stash push -m "$*"
      ;;

    pop)
      local target="${1:-0}"
      git stash pop "stash@{$target}"
      ;;

    drop)
      local target="${1:-0}"
      git stash drop "stash@{$target}"
      ;;

    *)
      echo "Usage:"
      echo "  stash list            - Lists the current stashes"
      echo "  stash add \"name\"    - Adds the current stash with a custom name"
      echo "  stash pop [<number>]  - Pops the top (0) stash, or the stash number if provided"
      echo "  stash drop [<number>] - Drops the top (0) stash, or the stash number if provided"
      return 1
      ;;
  esac
}

grm() {
  if [ -z $1 ]; then
    echo "No argument provided" >&2
    return 1
  fi
  echo "Removing $1 from the git cache. Make sure this path is in your .gitignore"
  git rm --cached "$1"
}

# Clean up garbage files
clean() {
  # Remove all .DS_Store files recursively
  echo "Removing all .DS_Store files..."

  # Check if in git repo
  if git rev-parse --git-dir > /dev/null 2>&1; then
    # Remove from git cache first, then delete files
    find . -type f -name "*.DS_Store" -exec git rm --cached {} \; 2> /dev/null
    find . -type f -name "*.DS_Store" -ls -delete
  else
    # Not in git repo, just delete files
    find . -type f -name "*.DS_Store" -ls -delete
  fi
  echo "Done."
}

# Print details about file permissions
perm() {
  for file in "$@"; do
    if stat --version > /dev/null 2>&1; then
      # GNU stat (Linux)
      perms=$(stat -c "%A" "$file")
      octal=$(stat -c "%a" "$file")
      owner=$(stat -c "%U" "$file")
      group=$(stat -c "%G" "$file")
    else
      # BSD stat (macOS)
      perms=$(stat -f "%Sp" "$file")
      octal=$(stat -f "%Lp" "$file")
      owner=$(stat -f "%Su" "$file")
      group=$(stat -f "%Sg" "$file")
    fi

    # Break it down
    type_char=${perms:0:1}
    u_perms=${perms:1:3}
    g_perms=${perms:4:3}
    o_perms=${perms:7:3}

    case $type_char in
      -) icon="📄" ;; # regular file
      d) icon="📁" ;; # directory
      l) icon="🔗" ;; # symlink
      *) icon="❓" ;;
    esac

    explain() {
      local p=$1
      local out=""
      [[ $p == *r* ]] && out+="read "
      [[ $p == *w* ]] && out+="write "
      [[ $p == *x* ]] && out+="execute"
      echo "${out%" "}" # trim trailing space
    }

    echo "$icon $file"
    echo "   Octal: $octal"
    echo "   Owner: $owner ($u_perms - $(explain $u_perms))"
    echo "   Group: $group ($g_perms - $(explain $g_perms))"
    echo "   Others: $o_perms ($(explain $o_perms))"
    echo
  done
}

# Cross platform stat command
st() {
  case "$(uname -s)" in
    Linux)
      stat -c "%A %a %n" "$@"
      ;;
    Darwin | FreeBSD | OpenBSD | NetBSD | DragonFly)
      stat -f "%Sp %Lp %N" "$@"
      ;;
    *)
      echo "st: unsupported operating system" >&2
      return 1
      ;;
  esac
}

nvim-update() {
  nvim --headless "+Lazy! sync" +qa
}

system-update() {
  case "$(uname -s)" in
    Linux)
      local ID=""
      if [[ -r /etc/os-release ]]; then
        ID=$(
          . /etc/os-release
          # Arch derivatives identify their base distribution in ID_LIKE.
          if [[ " ${ID_LIKE:-} " == *" arch "* ]]; then
            printf '%s' arch
          else
            printf '%s' "$ID"
          fi
        )
      fi

      case "$ID" in
        arch)
          echo "Updating system..."
          sudo pacman -Syyu
          ;;
        fedora)
          echo "Updating user Flatpaks..."
          flatpak update --user -y

          echo "Updating system Flatpaks..."
          sudo flatpak update --system -y

          echo "Updating system..."
          sudo dnf update --refresh
          ;;
        debian | ubuntu)
          echo "Updating system..."
          sudo apt update && sudo apt dist-upgrade
          ;;
      esac
      ;;
    Darwin)
      if command -v nvim > /dev/null 2>&1; then
        echo "Updating homebrew..."
        brew upgrade
      else
        echo "Homebrew not installed. Aborting."
      fi
      ;;
  esac

  if command -v nvim > /dev/null 2>&1; then
    echo "Updating Neovim plugins..."
    nvim-update
  fi
}
