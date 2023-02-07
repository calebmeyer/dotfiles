if status is-interactive
    # Commands to run in interactive sessions can go here
    alias cat bat
    alias ps procs
    alias ls exa
    alias dotnet6 /usr/local/opt/dotnet@6/bin/dotnet

    # Don't run HUSKY, I don't want it
    set -x HUSKY 0

    atuin init fish | source
end

# Don't use interactive for asdf, so it will work in scripts
source ~/.asdf/asdf.fish
