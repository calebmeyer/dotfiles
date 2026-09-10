function k9sprod --description "Point k9s at prod"
    k9s --context gke_hy-vee-shared-vpc-app-prod_us-central1_apps-v1-us-central1 --all-namespaces $argv
end
