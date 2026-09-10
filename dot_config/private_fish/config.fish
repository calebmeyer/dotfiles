# The following lines were added by Docker Desktop to add commands to your PATH.
export PATH="$PATH:/Users/h1532660/.docker/bin"
# End of Docker Desktop section.

set -gx PATH $HOME/.asdf/shims $PATH

if status is-interactive
    # plugin for bang bang support
	function last_history_item; echo $history[1]; end
	abbr -a !! --position anywhere --function last_history_item

	starship init fish | source
	zoxide init fish | source
	direnv hook fish | source
	if test "$TERM_PROGRAM" = "iTerm.app"
        source ~/.config/fish/.iterm2_shell_integration.fish
    end

    # https://github.com/rails/rails/issues/38560#issuecomment-590236052
    # Fixes an issue with running native rails extensions (like solid_queue)
    set -x OBJC_DISABLE_INITIALIZE_FORK_SAFETY yes

    alias cat bat
    alias ps procs
    alias dps oxker # docker ps
    alias ls eza
end
