# Allow scoop to be installed
Set-ExecutionPolicy RemoteSigned -scope CurrentUser

# Install scoop
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')

scoop install git
scoop bucket add nerd-fonts
scoop install Hack-NF

# TODO: fix windows terminal settings
