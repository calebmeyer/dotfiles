function checkport --description "Check if anything is running on the given port"
    netstat -vanp tcp | rg $argv

    if test $status -ne 0
        echo "Nothing is running on port $argv"
    end
end
