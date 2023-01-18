function git --description 'Run git with the npm token set'
    set -lx NPM_TOKEN (pass show npm_token)
    /usr/local/bin/git $argv
end
