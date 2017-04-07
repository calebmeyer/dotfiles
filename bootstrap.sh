#!/bin/sh
# This file bootstraps a Ubuntu (16.04+) or Fedora (25+) system with my dotfiles
# and a few programs I find essential.
# It's meant to be run once on a brand new system.

if grep -q Ubuntu /etc/os-release
   then
   echo "Installing essentials from aptitude..."
   sudo apt install -y curl fish zsh emacs vim build-essential git tree rbenv libssl-dev libreadline-dev zlib1g-dev \
                       libmysqlclient-dev libsqlite3-dev silversearcher-ag libncurses5 libncurses5-dev libncursesw5 \
                       tree
fi

if grep -q Fedora /etc/os-release
   then
   echo "Installing essentials from dandified yum (dnf)..."
   sudo dnf install -y curl fish zsh emacs vim git-core gcc gcc-c++ zlib zlib-devel readline readline-devel     \
                       libyaml-devel libffi-devel openssl-devel make autoconf automake sqlite-devel mysql-devel \
                       tree
fi

echo "Cloning dotfiles..."
git clone https://github.com/calebmeyer/dotfiles.git ~/.dotfiles

echo "Cloning rbenv and rbenv install..."
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

echo "Installing pyenv"
curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash

echo "Setting up dotfiles..."
sudo chmod +x ~/.dotfiles/install
fish ~/.dotfiles/install

echo "Installing source code pro..."
sudo chmod +x ~/.dotfiles/install_source_code_pro.sh
sh ~/.dotfiles/install_source_code_pro.sh

echo "Installing Spacemacs..."
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

echo "Installing Vundle..."
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo "Setting up fish..."
curl -L http://get.oh-my.fish | fish
# currently you have to type exit after the above step ^^
fish -c "omf install rbenv"
fish -c "omf install pyenv"
fish -c "omf install bobthefish"
fish -c "omf install bang-bang"

echo "Finished."
