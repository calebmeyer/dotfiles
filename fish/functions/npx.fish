function npx --description 'Run npx with the npm token set'
    set -lx NPM_TOKEN (pass show npm_token)
    /Users/H1532660/.asdf/shims/npx $argv
end
