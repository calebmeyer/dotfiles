function vault --wraps /opt/homebrew/bin/vault
    set -lx VAULT_ADDR https://vault.prod.hy-vee.cloud
    set -lx VAULT_TOKEN (/opt/homebrew/bin/vault login -method=oidc -path=okta -token-only)

    /opt/homebrew/bin/vault $argv
end
