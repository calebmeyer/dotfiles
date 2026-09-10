function kub_show_pod --description "Show a single pod for the default kubernetes namespace"
    set_color blue
    echo "> kubectl describe pod $argv"

    set_color normal
    kubectl describe pod $argv
end
