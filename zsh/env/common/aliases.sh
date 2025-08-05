if command -v lsd > /dev/null 2>&1; then
  local icons

  # If we are not inside an SSH or physical terminal session
  if [[ $(tty) != /dev/tty[1-6] ]]; then
    icons="always"
  else
    icons="never"
  fi

  alias ls="lsd --group-dirs=first --color=always --icon $icons"
fi

if command -v bat > /dev/null 2>&1; then
  alias cat="bat --paging=never --style=plain"
fi

alias sync="rsync -a --progress"
alias l="ls"
alias ll="ls -l"

# Print the current working directory every time we change it
cd() {
  builtin cd "$@" && ls
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
pull() {
  git pull --rebase
}
log() {
  git log --graph --oneline --decorate --all
}
alias push="git push"
alias pushh="git push -f"
alias commit="git commit -m"
reset() {
  if [ -z $1 ]; then
    git reset --hard HEAD
  else
    git reset --hard HEAD~$1
  fi
}
rebase() {
  git rebase -i HEAD~$1
}
reset-commit() {
  git commit --amend --reset-author --no-edit
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
  if stat --version > /dev/null 2>&1; then
    # GNU stat (Linux)
    stat -c "%A %a %n" "$@"
  else
    # BSD stat (macOS)
    stat -f "%Sp %Lp %N" "$@"
  fi
}
