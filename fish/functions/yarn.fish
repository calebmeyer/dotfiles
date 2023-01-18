function yarn --description 'Run yarn with the npm token set'
    set -lx NPM_TOKEN (pass show npm_token)
    set -lx CXXFLAGS "--std=c++17" # Fix older node-sass versions that don't want to compile on node 16+
    /Users/H1532660/.asdf/shims/yarn $argv
end
