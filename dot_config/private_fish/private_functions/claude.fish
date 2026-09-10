function claude --wraps claude
    set -gx GITHUB_PERSONAL_ACCESS_TOKEN (pass show mcp/github)
    set_dotnet_env

    echo "Set the secrets, opening claude..."
    command claude $argv
end
