function checkport --description "Check if anything is running on the given port"
    # print the netstat headers, highlight PID
    netstat -vanp tcp | sed -n '2 p' | rg ":pid"

    # then look for the program on the port
    netstat -vanp tcp | rg $argv

    if test $status -ne 0
        echo -e
        echo "* * * Nothing is running on port $argv * * *"
    end
end
