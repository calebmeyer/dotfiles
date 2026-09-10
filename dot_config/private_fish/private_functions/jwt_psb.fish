function jwt_psb --description "Builds a fake, unsigned JWT accepted by pharmacy-support-backend's local Auth concern (VERIFY_JWT_SIGNATURE is false, so it only checks for preferred_username/employeeid claims)"
    argparse 'u/username=' 'e/employeeid=' -- $argv
    or return

    set -l username $_flag_username
    set -l employeeid $_flag_employeeid
    test -n "$username"; or set username local.dev
    test -n "$employeeid"; or set employeeid 12345

    set -l access_token (python3 -c "
import base64, json, sys

def b64(data):
    return base64.urlsafe_b64encode(json.dumps(data).encode()).rstrip(b'=').decode()

username, employeeid = sys.argv[1], sys.argv[2]
header = {'alg': 'HS256', 'typ': 'JWT'}
payload = {
    'preferred_username': username,
    'employeeid': employeeid,
    'name': username,
    'email': f'{username}@hy-vee.com',
}
print(f'{b64(header)}.{b64(payload)}.sig')
" $username $employeeid)

    echo $access_token | pbcopy
    set -gx AUTH $access_token

    echo $access_token
    echo
    echo "Copied fake pharmacy-support-backend JWT to your clipboard and added it to \$AUTH."
    echo "Unsigned -- only works against a local server (VERIFY_JWT_SIGNATURE is false there)."
end
