function set_android_env
    set -gx ANDROID_HOME $HOME/Library/Android/sdk
    echo "Android Home: $ANDROID_HOME"

    fish_add_path $ANDROID_HOME/emulator
    fish_add_path $ANDROID_HOME/platform-tools
    fish_add_path $ANDROID_HOME/cmdline-tools/latest/bin

    . ~/.asdf/plugins/java/set-java-home.fish
end
