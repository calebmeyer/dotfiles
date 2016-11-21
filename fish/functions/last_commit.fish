function last_commit
	echo (git config --get remote.origin.url | sed 's/.git$//')/commit/(git log --pretty=format:"%H" | head -n1)
end
