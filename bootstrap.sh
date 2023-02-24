#!/bin/sh
# This file bootstraps a Ubuntu (16.04+) or Fedora (25+) or macOS
# system with my dotfiles
# and a few programs I find essential.
# It's meant to be run once on a brand new system.

# Detect the platform (similar to $OSTYPE)
OS="`uname`"
case $OS in
  'Linux')
    OS='Linux'
    ;;
  'FreeBSD')
    OS='FreeBSD'
    ;;
  'WindowsNT')
    OS='Windows'
    ;;
  'Darwin')
    OS='Mac'
    ;;
  'SunOS')
    OS='Solaris'
    ;;
  'AIX') ;;
  *) ;;
esac

echo "Detected OS as $OS"

if [ "$OS" == "Mac" ]
then
  echo "Fixing Key Repeat to work correctly (repeat keys instead of accented characters)"
  defaults write -g ApplePressAndHoldEnabled -bool false
  
  echo "Installing homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo "Installing essentials from brew"
  brew tap homebrew/cask-fonts
  brew install fish emacs neovim git tree ripgrep exa bat mysql wget font-hack font-source-code-pro procs \
               iterm2 firefox bettertouchtool alfred4 font-hack-nerd-font duti python-yq zellij mprocs
  # fix press and hold a key to do the right thing (repeat) instead of the wrong thing (bring up a list of accented characters)
  defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
  
  # set VS Code as default editor for all file types github recognizes
  curl "https://raw.githubusercontent.com/github/linguist/master/lib/linguist/languages.yml" \
      | yq -r "to_entries | (map(.value.extensions) | flatten) - [null] | unique | .[]" \
      | xargs -L 1 -I "{}" duti -s com.microsoft.VSCode {} all
elif [ "$OS" == "Linux" ]
then
  if grep -q Ubuntu /etc/os-release
  then
    sudo apt-add-repository ppa:fish-shell/release-3 # gets a newer fish

    sudo apt install -y curl

    curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - # gets a newer node

    echo "Getting the latest updates from aptitude..."
    sudo apt update
    echo "Installing essentials from aptitude..."
    sudo apt install -y fish zsh emacs vim build-essential git tree libssl-dev libreadline-dev zlib1g-dev \
                       libmysqlclient-dev libsqlite3-dev ripgrep libncurses5 libncurses5-dev libncursesw5 \
                       yarn nodejs sqlite3 exa bat fonts-hack-ttf
  fi

  if grep -q Fedora /etc/os-release
  then
    sudo wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo # gets a newer yarn
    echo "Getting the latest updates from dandified yum (dnf)..."
    sudo dnf update
    echo "Installing essentials from dandified yum (dnf)..."
    sudo dnf install -y curl fish zsh emacs vim git-core gcc gcc-c++ zlib zlib-devel readline readline-devel     \
                         libyaml-devel libffi-devel openssl-devel make autoconf automake sqlite-devel mysql-devel \
                         tree yarn ripgrep exa bat adobe-source-code-pro-fonts
  fi
else
  echo "Unsupported OS: $OS"
fi

echo "Cloning dotfiles..."
git clone https://github.com/calebmeyer/dotfiles.git ~/.dotfiles

echo "Setting up dotfiles..."
sudo chmod +x ~/.dotfiles/install
fish ~/.dotfiles/install

echo "Setting up the asdf version manager"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
cd ~/.asdf
git checkout "$(git describe --abbrev=0 --tags)"

echo "source ~/.asdf/asdf.fish" >> ~/.config/fish/config.fish
mkdir -p ~/.config/fish/completions; and cp ~/.asdf/completions/asdf.fish ~/.config/fish/completions

echo "Installing Spacemacs..."
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

echo "Installing Vundle..."
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo "Setting up fish..."
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher

echo "Changing shell to fish..."
sudo chsh -s `which fish`

if ! fish -c "fisher ls" | grep -iq bobthefish
then
  fish -c "fisher install oh-my-fish/theme-bobthefish oh-my-fish/plugin-bang-bang"
fi
fish -c "alias ls exa"
fish -c "alias cat bat"

echo "Finished."
