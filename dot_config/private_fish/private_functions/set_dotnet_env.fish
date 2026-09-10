function set_dotnet_env
    set -gx DOTNET_BASE (dotnet --info | grep "Base Path" | awk '{print $3}')
    echo "DOTNET_BASE: $DOTNET_BASE"

    set -gx DOTNET_ROOT (echo $DOTNET_BASE | sed -E "s/^(.*)(\/sdk\/[^\/]+\/)\$/\1/")
    echo "DOTNET_ROOT: $DOTNET_ROOT"

    set -gx MSBuildSDKsPath $DOTNET_BASE/Sdks/

    set -gx NUGET_API_KEY (pass show nuget_api_key)
end
