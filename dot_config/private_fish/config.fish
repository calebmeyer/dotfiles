if status is-interactive
    # Commands to run in interactive sessions can go here
	function last_history_item; echo $history[1]; end 
	abbr -a !! --position anywhere --function last_history_item

	starship init fish | source
	zoxide init fish | source
	direnv hook fish | source
end
