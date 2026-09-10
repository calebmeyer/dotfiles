function kdev --description "Change kubernetes over to dev"
    gcloud container clusters get-credentials apps-v1-us-central1 \
        --region us-central1 \
        --project hy-vee-shared-vpc-app-dev

    kubectl config use-context \
        gke_hy-vee-shared-vpc-app-dev_us-central1_apps-v1-us-central1
end
