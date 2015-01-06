#!/usr/bin/env bash
echo "Installing Posquit0's dotfiles"

# If Git is not installed, install it (Ubuntu only, since Git comes standard
# with recent XCode or CLT)
if [[ ! "$(type -P git)" && "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]]; then
    echo "Installing Git"
    sudo apt-get -qq install git-core
fi

# If Git isn't installed by now, something exploded. We gots to quit!
if [[ ! "$(type -P git)" ]]; then
    echo "ERROR: Git should be installed. It isn't. Aborting."
    exit 1
fi

# Download or update.
if [[ ! -d ~/.dotfiles ]]; then
    # ~/.dotfiles doesn't exist? Clone it!
    echo "Cloning dotfiles to ~/.dotfiles"
    cd
    git clone --recursive https://github.com/posquit0/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
else
    # Make sure we have the latest files.
    echo "Updating dotfiles"
    cd ~/.dotfiles
    git pull
    git submodule update --init --recursive --quiet
fi

echo "Installation complete!"
