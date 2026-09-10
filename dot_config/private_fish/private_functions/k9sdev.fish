function k9sdev --description "Point k9s at dev"
    k9s --context gke_hy-vee-shared-vpc-app-dev_us-central1_apps-v1-us-central1 --all-namespaces $argv
end
