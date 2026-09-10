function main --description "Checks out the main (or master) branch and pulls"
    git branch | rg main

    if test $status -eq 0
        git checkout main
    else
        git checkout master
    end

    git pull
end
