function employee_http --description "HTTPie wrapper that appends a fake pharmacy-support-backend employee bearer token (jwt_psb)"
    argparse 'u/username=' 'e/employeeid=' -- $argv
    or return

    jwt_psb --username=$_flag_username --employeeid=$_flag_employeeid 1> /dev/null

    http -A bearer -a $AUTH $argv
end
