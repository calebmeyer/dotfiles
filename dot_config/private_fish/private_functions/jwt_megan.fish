function jwt_megan
    set -l body (jq -nc \
        --arg username 'mehill@hy-vee.com' \
        --arg password (pass show jwt/megan-password) \
        --arg client_secret (pass show jwt/auth0-client-secret) \
        '{
            grant_type: "password",
            username: $username,
            password: $password,
            audience: "urn:hy-vee:customer",
            client_id: "YowJirlomaemvCz2JEmMZpaGyqywS3aJ",
            client_secret: $client_secret,
            scope: "openid profile email offline_access"
        }')

    set -l jwt (curl --silent --request POST \
        --url https://identity-dev.hy-vee.com/oauth/token \
        --header 'content-type: application/json' \
        --data $body)

    echo $jwt | jq .

    echo $jwt | jq .access_token | tr -d '"' | tr -d "\n" | pbcopy

    echo
    echo "Copied access token to your clipboard."
end
