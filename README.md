# dotfiles
my personal dotfiles.

Sets up git, fish, zsh, antigen, emacs, vim, macvim, and a few more.

`brew install fish`

then ./install to get started.

# Bootstrapping
For Ubuntu (16.04 or later) or Fedora (25+) you can instead run bootstrap.sh, which installs a
lot of prerequisites, then installs the dotfiles.

`curl -s https://raw.githubusercontent.com/calebmeyer/dotfiles/master/bootstrap.sh | bash`

Note that you'll still need to run :PluginInstall in vim, run emacs once to
allow spacemacs to install its packages, and `rbenv install` whatever ruby
version you want.

Also note that for a virtual box ubuntu VM, you may want to turn on dns from the host for VPN to work:
```
PATH=%PATH%;C:\Program Files\Oracle\VirtualBox
VBoxManage list vms
VBoxManage modifyvm <uuid here> --natdnshostresolver1 on
```
