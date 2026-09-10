function encrypt_secret --description "Encrypt a secret using gcloud KMS"
    echo -n "$argv" | gcloud kms encrypt \
        --project hy-vee-kms \
        --location global \
        --keyring pharmacy \
        --key pharmacy-support-dev \
        --ciphertext-file - \
        --plaintext-file - \
        | base64
end
