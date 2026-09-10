function guest_http
    create_session 1> /dev/null

    ahttp $argv Session-ID:$SESSION_ID
end
