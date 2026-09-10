function ahttp --description "HTTPie wrapper that appends bearer authentication"
    argparse 'u/username=' 'p/password=' -- $argv
    or return

    jwt --username=$_flag_username --password=$_flag_password 1> /dev/null

    http -A bearer -a $AUTH $argv
end
