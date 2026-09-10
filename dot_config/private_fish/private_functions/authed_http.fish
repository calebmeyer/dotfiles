function authed_http
    argparse 'u/username=' 'p/password=' -- $argv
    or return

    create_session 1> /dev/null
    authenticate_session $_flag_username $_flag_password 1> /dev/null
    or return

    ahttp $argv Session-ID:$SESSION_ID --username=$_flag_username --password=$_flag_password
end
