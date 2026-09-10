function kub_get_pods --description "Show all pods for a given kubernetes namespace"
    set_color blue

    if test -e $argv
        echo "Using the existing default namespace"
        echo "> kubectl get pods"

        set_color normal
        kubectl get pods

        return
    end

    echo "Setting $argv as the default namespace"
    echo "> kubectl config set-context --current --namespace=$argv"

    set_color normal
    kubectl config set-context --current --namespace=$argv

    set_color blue
    echo "> kubectl get pods"

    set_color normal
    kubectl get pods
end
