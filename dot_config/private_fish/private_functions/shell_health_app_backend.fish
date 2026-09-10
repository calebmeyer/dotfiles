function shell_health_app_backend
    set cluster "gke_hy-vee-shared-vpc-app-prod_us-central1_apps-v1-us-central1"
    set namespace "health-application-backend"
    set pod_name (kubectl --context $cluster -n $namespace get pods -o jsonpath='{.items[*].metadata.name}' | tr ' ' '\n' | grep -E '^'$namespace'-[a-z0-9]+-[a-z0-9]+$' | head -1)

    if test -z "$pod_name"
        echo "No pod matching namespace name found in $namespace namespace"
        return 1
    end

    echo "Pod: $namespace/$pod_name | Container: $namespace"
    kubectl --context $cluster -n $namespace --container $namespace exec -it $pod_name -- /bin/sh -c 'bin/rails console'
end
