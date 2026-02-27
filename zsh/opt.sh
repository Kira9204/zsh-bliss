#!/usr/bin/env zsh
# Disables global expansion of special characters like '*'
unsetopt KSH_GLOB

# Will delete patterns which don’t match anything (so they will be effectively ignored);
# This makes zsh behave like bash
setopt nullglob
