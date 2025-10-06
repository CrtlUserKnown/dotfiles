#!/usr/bin/env bash

# --- Charfiles:macOS install script ---
#
# date created: 08.29.2025

# --- gum ---
# ensure gum is installed (silent)
install_gum() {
    if ! command -v gum &> /dev/null; then
        tmpdir=$(mktemp -d)
        curl -sSL "https://github.com/charmbracelet/gum/releases/latest/download/gum_$(uname -s)_$(uname -m).tar.gz" \
        | tar -xz -C "$tmpdir"
        sudo mv "$tmpdir/gum" /usr/local/bin/gum >/dev/null 2>&1
        rm -rf "$tmpdir"
    fi
}

# install gum if missing
install_gum

# --- package manager:homebrew ---
# install Homebrew on to the system
if command -v brew &> /dev/null; then
    echo "✅ Homebrew is already installed."
else
    echo "🚀 Homebrew not found. Installing..."
    
    # download the installer script first
    gum spin --spinner dot --title "Downloading Homebrew installer..." -- \
        curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o /tmp/homebrew_install.sh
    
    # run the installer (needs to be interactive)
    gum spin --spinner dot --title "Running Homebrew installer..." -- /bin/bash /tmp/homebrew_install.sh
    
    # Clean up
    rm -f /tmp/homebrew_install.sh

    # Add Homebrew to PATH if necessary
    if [[ -d "/opt/homebrew/bin" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -d "/usr/local/bin" ]]; then
        echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/usr/local/bin/brew shellenv)"
    fi

    echo "✅ Homebrew installation complete."
fi

# --- packages:Brewfile ---
# install Homebrew files
brew bundle

# --- configuration:.config ---
# make syslinks for config
gum spin --spinner dot --title "Checking for configuration files "

if [ ! -d ~/.config ]; then
    gum spin --spinner dot --title "Creating Config folder..." -- /bin/bash/ mkdir ~/.config
    sleep 1
else
    echo "✅ Config directory already exists!"
fi

# --- configuration:Charfiles ---
# make charfiles directory
if [ -d ~/.charfiles ]; then
        gum spin --spinner dot --title "Making Charfiles directory..." -- /bin/bash/ mkdir -p ~/.charfile && git clone https://github.com/Charlynder/Charfiles.git ~/.charfile
        sleep 1
else
        echo "Charfiles directory has already been created ✅"
fi

# --- configuration:Edits ---
# remove the install script from the installation
rf -rf ~/.charfiles/install.sh

# --- configuration:Links ---
# make links for configurations
gum spin --spinner dot --title "Creating links for configuration file..." -- /bin/bash/ ln -s ~/.charfile/*/ ~/.config/ \

