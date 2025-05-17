# Disable beeps
unsetopt beep

# Disable live job notifications
unsetopt notify

# Extended globbing
setopt extendedglob

# No = expansion
unsetopt equals

# Correction
setopt correct

# Prevent throwing an error when a pattern is not found
setopt no_nomatch

# Unicode combining characters support
setopt combining_chars

# Allow comments
setopt interactive_comments

# Remove RPS1 after <enter>
setopt transient_rprompt
setopt prompt_cr
setopt prompt_sp

# Watch for login/logout
watch=all

bindkey '[1~' beginning-of-line
bindkey '[4~' end-of-line

# Edit cmdline
autoload edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line

# Complete help
bindkey '^xc' _complete_help

# Completion cache
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Colored completion
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# ... expansion
autoload -Uz manydots-magic
manydots-magic

# Pattern-matching mv
autoload zmv

# vim: set ts=4 sw=4 cc=80 :
