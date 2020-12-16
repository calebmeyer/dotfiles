# dotfiles
my personal dotfiles.

Sets up git, fish, zsh, antigen, emacs, vim, macvim, and a few more.

`brew install fish`

then ./install to get started.

# Bootstrapping
For Ubuntu (16.04 or later) or Fedora (25+) or macOS you can instead run bootstrap.sh, which installs a
lot of prerequisites, then installs the dotfiles.

`curl -s https://raw.githubusercontent.com/calebmeyer/dotfiles/master/bootstrap.sh | bash`

Note that you'll still need to run :PluginInstall in vim, run emacs once to
allow spacemacs to install its packages, and `rbenv install` whatever ruby
version you want.

Also note that for a virtual box VM, you may want to turn on dns from the host for VPN to work:
```
PATH=%PATH%;C:\Program Files\Oracle\VirtualBox
VBoxManage list vms
VBoxManage modifyvm <uuid here> --natdnshostresolver1 on
```

# For Fedora on Hyper-V
The default resolution is tiny, so this sets it to 1080p
```
grubby --update-kernel=ALL --args="video=hyperv_fb:1920x1080"
reboot
```
