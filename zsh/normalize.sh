#!/usr/bin/env zsh
# Disables global expansion of special characters like '*'
# This makes zsh behave like bash
unsetopt KSH_GLOB

# Will delete patterns which don’t match anything (so they will be effectively ignored);
# This makes zsh behave like bash
setopt nullglob

# Restore Home, End, Delete and Backspace keys to their normal behavior
bindkey '^[[H' beginning-of-line  # Home
bindkey '^[[F' end-of-line        # End
bindkey '^[[3~' delete-char       # Delete
bindkey '^?' backward-delete-char # Backspace

# Make sure that base utils behave in a normal consistent way across platforms
unalias cp > /dev/null 2>&1 # Some platforms have cp aliased to 'cp -i' which can cause issues in scripts
unalias mv > /dev/null 2>&1 # Some platforms have mv aliased to 'mv -i' which can cause issues in scripts
unalias rm > /dev/null 2>&1 # Some platforms have rm aliased to 'rm -i' which can cause issues in scripts
alias ls='ls --color=auto'

local exlude_dirs="--exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox,.venv,venv}"
alias grep="grep --color=auto $exlude_dirs"
alias fgrep="grep -F --color=auto $exlude_dirs"
alias egrep="grep -E --color=auto $exlude_dirs"
alias xzegrep='xzegrep --color=auto'
alias xzfgrep='xzfgrep --color=auto'
alias xzgrep='xzgrep --color=auto'
alias zegrep='zegrep --color=auto'
alias zfgrep='zfgrep --color=auto'
alias zgrep='zgrep --color=auto'

alias vi=vim
alias which='alias | /usr/bin/which --tty-only --read-alias --show-tilde --show-dot'
