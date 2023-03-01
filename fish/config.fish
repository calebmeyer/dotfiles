if status is-interactive
    # Commands to run in interactive sessions can go here
    alias cat bat
    alias ps procs
    alias ls exa
    alias tmux zellij

    set -gx ATUIN_NOBIND "true"
    atuin init fish | source

    bind \cr _atuin_search
end

# Don't use interactive for rtx, so it will work in scripts
/usr/local/bin/rtx activate fish | source
