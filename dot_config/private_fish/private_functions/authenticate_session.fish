function authenticate_session
    set -l username $argv[1]
    set -l password $argv[2]
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

    set -l access_token (echo $jwt | jq -r '.access_token // empty' 2> /dev/null)
    set -l refresh_token (echo $jwt | jq -r '.refresh_token // empty' 2> /dev/null)
    set -l id_token (echo $jwt | jq -r '.id_token // empty' 2> /dev/null)

    if test -z "$access_token"
        echo "authenticate_session: failed to get an access token. Raw response from the Auth0 token endpoint:" 1>&2
        echo $jwt 1>&2
        return 1
    end

    set -l response (http --print=b POST https://api.dev.hy-vee.cloud/main/v1/sessions/$SESSION_ID/authenticate \
        -A bearer -a $access_token \
        token:="{\"access_token\":\"$access_token\",\"refresh_token\":\"$refresh_token\",\"id_token\":\"$id_token\"}")

    if not echo $response | jq . 2> /dev/null
        echo "authenticate_session: session-authenticate call did not return valid JSON. Raw response:" 1>&2
        echo $response 1>&2
        return 1
    end
end
