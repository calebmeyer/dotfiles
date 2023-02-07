function yarn --description "wraps yarn and makes sure I'm on vpn"
    if not ifconfig utun3 > /dev/null # if not on VPN
        echo "*** GET ON VPN ***"
    end
    set -lx CXXFLAGS "--std=c++17" # Fix older node-sass versions that don't want to compile on node 16+

    /Users/H1532660/.asdf/shims/yarn $argv
end
