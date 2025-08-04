# Restore Home, End, Delete and Backspace keys to their normal behavior

bindkey '^[[H' beginning-of-line  # Home
bindkey '^[[F' end-of-line        # End
bindkey '^[[3~' delete-char       # Delete
bindkey '^?' backward-delete-char # Backspace
