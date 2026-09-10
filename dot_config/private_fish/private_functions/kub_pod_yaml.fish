function kub_pod_yaml --description "Show a pod's yaml config"
    set_color blue
    echo "> kubectl get pod $argv -o yaml"

    set_color normal
    kubectl get pod $argv -o yaml
end
