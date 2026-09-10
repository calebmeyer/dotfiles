function sync_obsidian
    cd ~/code/side_projects/obsidian-notes
    git pull --rebase --autostash
    git add .
    set current_date date
    git commit -m "Auto-synced at $current_date"
    git push
    echo "Successfully synced obsidian notes."

    cd -
end
