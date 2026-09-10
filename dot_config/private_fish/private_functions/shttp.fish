function shttp --description "HTTPie wrapper that appends service account bearer authentication"
    jwt_hab 1> /dev/null

    http -A bearer -a $AUTH $argv
end
