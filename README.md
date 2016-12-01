# dotfiles
my personal dotfiles.

Sets up git, fish, zsh, antigen, emacs, vim, macvim, and a few more.

`brew install fish`

then ./install to get started.

# Bootstrapping Ubuntu
For Ubuntu (16.04 or later) you can instead run bootstrap.sh, which installs a
lot of prerequisites, then installs the dotfiles.

`curl -s https://raw.githubusercontent.com/calebmeyer/dotfiles/master/bootstrap.sh | bash`

Note that you'll still need to run :PluginInstall in vim, run emacs once to
allow spacemacs to install its packages, and `rbenv install` whatever ruby
version you want.
