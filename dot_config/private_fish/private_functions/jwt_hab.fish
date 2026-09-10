function jwt_hab --description "Obtains a client credentials JWT for the health-application-backend service account"
    set -l jwt (curl --silent --request POST \
        --url https://dev-accounts.hy-vee.com/auth/realms/customer/protocol/openid-connect/token \
        --header 'content-type: application/x-www-form-urlencoded' \
        --data client_id=health-application-backend \
        --data grant_type=client_credentials \
        --data "client_secret="(pass show jwt/hab-client-secret))

    echo $jwt | jq .

    set -l access_token (echo $jwt | jq .access_token | tr -d '"' | tr -d "\n")

    echo $access_token | pbcopy
    set -gx AUTH $access_token

    echo
    echo "Copied access token to your clipboard and added it to \$AUTH."
end
