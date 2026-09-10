function kprod --description "Change kubernetes over to prod"
    gcloud container clusters get-credentials apps-v1-us-central1 \
        --region us-central1 \
        --project hy-vee-shared-vpc-app-prod

      kubectl config use-context \
        gke_hy-vee-shared-vpc-app-prod_us-central1_apps-v1-us-central1
end
