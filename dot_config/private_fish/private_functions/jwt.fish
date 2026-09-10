function jwt
    argparse 'u/username=' 'p/password=' -- $argv
    or return

    set -l username $_flag_username
    set -l password $_flag_password
    test -n "$username"; or set username caleb.meyer@hy-vee.com
    test -n "$password"; or set password (pass show jwt/me-password)

    set -l body (jq -nc \
        --arg username $username \
        --arg password $password \
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

    set -l access_token (echo $jwt | jq .access_token | tr -d '"' | tr -d "\n")

    echo $access_token | pbcopy
    set -gx AUTH $access_token

    echo
    echo "Copied access token to your clipboard and added it to \$AUTH."
end
