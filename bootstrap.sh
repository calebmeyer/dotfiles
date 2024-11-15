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
               iterm2 firefox bettertouchtool alfred4 font-hack-nerd-font duti python-yq zellij mprocs \
               jdxcode/tap/rtx atuin
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
    wget -qO - https://rtx.pub/gpg-key.pub | gpg --dearmor | sudo tee /usr/share/keyrings/rtx-archive-keyring.gpg 1> /dev/null
    echo "deb [signed-by=/usr/share/keyrings/rtx-archive-keyring.gpg arch=amd64] https://rtx.pub/deb stable main" | sudo tee /etc/apt/sources.list.d/rtx.list

    sudo apt install -y curl

    echo "Getting the latest updates from aptitude..."
    sudo apt update
    echo "Installing essentials from aptitude..."
    sudo apt install -y fish zsh emacs vim build-essential git tree libssl-dev libreadline-dev zlib1g-dev \
                       libmysqlclient-dev libsqlite3-dev ripgrep libncurses5 libncurses5-dev libncursesw5 \
                       yarn nodejs sqlite3 exa bat fonts-hack-ttf rtx procs zellij atuin
  fi

  if grep -q Fedora /etc/os-release
  then
    echo "Getting the latest updates from dandified yum (dnf)..."
    sudo dnf update
    
    # set up rtx
    dnf install -y dnf-plugins-core
    dnf config-manager --add-repo https://rtx.pub/rpm/rtx.repo
    
    echo "Installing essentials from dandified yum (dnf)..."
    sudo dnf install -y curl fish zsh emacs vim git-core gcc gcc-c++ zlib zlib-devel readline readline-devel      \
                         libyaml-devel libffi-devel openssl-devel make autoconf automake sqlite-devel mysql-devel \
                         tree yarn ripgrep exa bat adobe-source-code-pro-fonts rtx procs zellij atuin
  fi
else
  echo "Unsupported OS: $OS"
fi

echo "Cloning dotfiles..."
git clone https://github.com/calebmeyer/dotfiles.git ~/.dotfiles

echo "Setting up dotfiles..."
sudo chmod +x ~/.dotfiles/install
fish ~/.dotfiles/install

echo "Installing Vim Plugin Manager..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Setting up fish..."
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher

echo "Changing shell to fish..."
sudo chsh -s `which fish`

if ! fish -c "fisher ls" | grep -iq bobthefish
then
  fish -c "fisher install oh-my-fish/theme-bobthefish oh-my-fish/plugin-bang-bang jethrokuan/z"
fi

echo "Finished."
