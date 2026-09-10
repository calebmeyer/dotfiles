function fixicons
    # Slack
    sudo cp ~/Pictures/icons/slack.icns "/Applications/Slack.app/Contents/Resources/electron.icns"
    sudo touch "/Applications/Slack.app"

    # VS Code
    sudo cp ~/Pictures/icons/code.icns "/Applications/Visual Studio Code.app/Contents/Resources/Code.icns"
    sudo touch "/Applications/Visual Studio Code.app"

    # Outlook
    sudo cp ~/Pictures/icons/outlook.icns "/Applications/Microsoft Outlook.app/Contents/Resources/Outlook.icns"
    sudo touch "/Applications/Microsoft Outlook.app"

    sudo rm -rf /Library/Caches/com.apple.iconservices.store
    sudo killall Dock
end
