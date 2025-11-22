# ~/.bashrc

# Set vim as default editor
export VISUAL=vim
export EDITOR=vim

# fzf configuration with orange/amber theme
export FZF_DEFAULT_OPTS="
  --height=40%
  --layout=reverse
  --info=inline
  --border
  --margin=1
  --padding=1
  --bind='ctrl-o:execute(vim {})'
  --color=fg:#e0e0e0,bg:#1e1e1e,hl:#ff9e64
  --color=fg+:#ffffff,bg+:#2a2a2a,hl+:#ffb86c
  --color=info:#ff9e64,prompt:#ffb86c,pointer:#ffb86c
  --color=marker:#ffb86c,spinner:#ff9e64,header:#ff9e64
"

# Enable fzf key bindings and completion if installed
if command -v fzf >/dev/null 2>&1; then
    # Source fzf bash integration
    eval "$(fzf --bash)"
fi

# Set PATH additions
export PATH="$HOME/bin:$PATH"

# Common aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Enable color for ls, grep, etc.
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Some handy shell options
shopt -s histappend   # Append history, don’t overwrite
shopt -s checkwinsize # Update LINES and COLUMNS after resizing terminal

# load aliases and functions from ~/.bash_aliases if it exists
if [ -f ~/.config/bash/.aliases ]; then
    . ~/.config/bash/.aliases
fi

PROMPT_COMMAND='PS1_CMD1=$(git branch --show-current 2>/dev/null)'; PS1='${PS1_CMD1} \w \[\e[38;2;255;233;123m\]>\[\e[0m\] '

# # load zoxide in bash if installed
# if command -v zoxide >/dev/null 2>&1; then
#     eval "$(zoxide init bash)"
# fi
