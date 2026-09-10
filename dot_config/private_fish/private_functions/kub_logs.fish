function kub_logs --description "Show logs for a given pod"
    set_color blue

    if test -e $argv
        set_color red
        echo "Please pass a pod name"

        return
    end
    echo "> kubectl logs $argv"

    set_color normal
    kubectl logs $argv
end
