# asdf-java (zulu) doesn't ship a list-bin-paths hook, so `asdf reshim`
# can't create a `java` shim — its bin/ lives nested under Contents/Home.
# Resolve JAVA_HOME from the actual asdf install and put its bin on PATH.
if status is-interactive
    function __asdf_java_update_home --on-event fish_prompt
        set -l java_root (asdf where java 2>/dev/null)
        if test -n "$java_root"
            if test -d "$java_root/Contents/Home/bin"
                set -gx JAVA_HOME "$java_root/Contents/Home"
            else if test -d "$java_root/bin"
                set -gx JAVA_HOME "$java_root"
            else
                set -e JAVA_HOME
            end
            if set -q JAVA_HOME
                set -gx JDK_HOME "$JAVA_HOME"
                fish_add_path -g "$JAVA_HOME/bin"
            end
        end
    end
    __asdf_java_update_home
end
