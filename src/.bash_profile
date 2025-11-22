# .bash_profile
# Source the .bashrc file if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# set homebrew path
eval "$(/opt/homebrew/bin/brew shellenv)"

# enable bash-completeions
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

# run neofetch once at login
neofetch

[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

# load zoxide in bash if installed
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init bash)"
fi
