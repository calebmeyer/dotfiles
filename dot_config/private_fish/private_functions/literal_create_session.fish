function create_session
    set -l session_id (http --print=h GET https://dev.hy-vee.com \
        | grep -o 'hyveeSessionId=[^;]*' \
        | cut -d= -f2)

    set -gx SESSION_ID $session_id

    echo "Session ID set as \$SESSION_ID: $session_id"
end
