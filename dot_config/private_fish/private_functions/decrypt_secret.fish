function decrypt_secret --description "Decrypt a secret using gcloud KMS"
    echo -n "$argv" \
        | base64 --decode \
        | gcloud kms decrypt \
        --project hy-vee-kms \
        --location global \
        --keyring pharmacy \
        --key pharmacy-support-dev \
        --ciphertext-file - \
        --plaintext-file -
end
